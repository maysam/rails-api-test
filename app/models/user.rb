# frozen_string_literal: true

class User < ApplicationRecord
  has_one :state_id, dependent: :destroy, inverse_of: :user
  has_many :medical_recommendations, dependent: :destroy, inverse_of: :user

  validates :name, :email, :date_of_birth, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  accepts_nested_attributes_for :state_id, allow_destroy: true
  accepts_nested_attributes_for :medical_recommendations, allow_destroy: true
end
