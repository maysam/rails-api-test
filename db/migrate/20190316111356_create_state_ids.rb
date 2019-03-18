# frozen_string_literal: true

class CreateStateIds < ActiveRecord::Migration[5.2]
  def change
    create_table :state_ids do |t|
      t.references :user, foreign_key: true, null: false
      t.string :number, null: false
      t.string :state, null: false
      t.date :expiration_date, null: false
      t.string :image, null: false

      t.timestamps
    end
    add_index :state_ids, :number, unique: true
    add_index :state_ids, :state
  end
end
