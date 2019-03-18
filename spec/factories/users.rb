FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.safe_email }
    date_of_birth { Faker::Date.between('1950-01-01', '2000-01-01') }

    after(:build) do |user|
      user.state_id ||= build(:state_id, user: user)

      if user.medical_recommendations.empty?
        user.medical_recommendations = build_list(:medical_recommendation, 1, user: user)
      end
    end
  end
end
