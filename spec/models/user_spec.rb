# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it { should have_one(:state_id) }
  it { should have_many(:medical_recommendations) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:date_of_birth) }
  it { should validate_uniqueness_of(:email).case_insensitive }

  context 'has a valid factory' do
    it { should be_valid }
  end
end
