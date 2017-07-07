class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |table|
      table.string :name, null: false
      table.datetime :time, null: false
      table.string :description, null: false
      table.string :location, null: false
      table.integer :creator_id, null: false

      table.timestamps
    end
  end
end
