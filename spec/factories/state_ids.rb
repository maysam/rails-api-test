# frozen_string_literal: true

FactoryBot.define do
  factory :state_id do
    number { Faker::IDNumber.valid }
    state { Faker::Address.state }
    expiration_date { Faker::Date.between('2020-01-01', '2025-12-31') }
    remote_image_url { Faker::Placeholdit.image }

    after(:build) do |state_id|
      state_id.user ||= build(:user, state_id: state_id)
    end
  end
end
