# frozen_string_literal: true

class CreateMedicalRecommendations < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_recommendations do |t|
      t.references :user, foreign_key: true, null: false
      t.string :number, null: false
      t.string :issuer, null: false
      t.string :state, null: false
      t.date :expiration_date, null: false
      t.string :image, null: false

      t.timestamps
    end
    add_index :medical_recommendations, :number, unique: true
  end
end
