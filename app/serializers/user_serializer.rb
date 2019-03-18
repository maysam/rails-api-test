class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :date_of_birth, :created_at, :updated_at

  has_one :state_id
  has_many :medical_recommendations
end
