# frozen_string_literal: true

class MedicalRecommendation < ApplicationRecord
  include Expirable

  belongs_to :user, inverse_of: :medical_recommendations
  validates :user, :number, :issuer, :state, :expiration_date, :image, presence: true

  validates :number, uniqueness: { case_sensitive: false }

  mount_uploader :image, DocumentUploader
end
