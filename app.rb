require 'sinatra'
require_relative 'config/application'

set :bind, '0.0.0.0'  # bind to all interfaces

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups/new' do
  @errors = []
  if session[:user_id].nil?
    flash[:notice] = "You must be signed in to create a new meetup"
    redirect '/meetups'
  else
    erb :'meetups/new'
  end
end

get '/meetups/:id' do
  @meetup = Meetup.find(params[:id])
  erb :'meetups/show'
end

get '/meetups' do
  @meetups = Meetup.all
  erb :'meetups/index'
end

post '/meetups/new' do
  @meetup = Meetup.new(
    name: params[:name],
    location: params[:location],
    description: params[:description],
    time: Time.now(),
    creator: User.find(session[:user_id]))

  if @meetup.valid?
    @meetup.save
    flash[:notice] = "Your meetup was successfully created"
    redirect '/meetups'
  else
    @errors = @meetup.errors.full_messages
    erb :'meetups/new'
  end
end
