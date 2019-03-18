FactoryBot.define do
  factory :medical_recommendation do
    number { Faker::IDNumber.valid }
    issuer { 'Medical Recommendation Issuer' }
    state { Faker::Address.state }
    expiration_date { Faker::Date.between('2020-01-01', '2025-12-31') }
    remote_image_url { Faker::Placeholdit.image }

    after(:build) do |medical_recommendation|
      medical_recommendation.user ||= build(:user, medical_recommendations: [medical_recommendation])
    end
  end
end
