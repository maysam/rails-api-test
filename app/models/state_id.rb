# frozen_string_literal: true

class StateId < ApplicationRecord
  include Expirable

  belongs_to :user, inverse_of: :state_id

  validates :user, :number, :state, :expiration_date, :image, presence: true
  validates :number, uniqueness: { case_sensitive: false }

  mount_uploader :image, DocumentUploader
end
