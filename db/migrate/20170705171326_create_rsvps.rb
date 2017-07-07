class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.integer :attendee_id, null: false
      t.integer :meetup_id, null: false

      t.timestamps
    end
  end
end
