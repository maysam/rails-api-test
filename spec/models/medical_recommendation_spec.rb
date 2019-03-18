require 'rails_helper'

RSpec.describe MedicalRecommendation, type: :model do
  subject(:medical_recommendation) { build(:medical_recommendation, user: build(:user)) }

  it_behaves_like 'expirable'

  it { should belong_to(:user) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:issuer) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:expiration_date) }
  it { should validate_presence_of(:image) }
  it { should validate_uniqueness_of(:number).case_insensitive }

  context 'has a valid factory' do
    it { should be_valid }
  end
end
