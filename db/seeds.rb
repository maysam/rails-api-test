20.times do
  user = User.find_or_create_by(email: Faker::Internet.safe_email) do |user|
    user.name = Faker::Name.name
    user.date_of_birth = Faker::Date.between('1950-01-01', '2000-01-01')
  end

  StateId.find_or_create_by(number: Faker::IDNumber.valid) do |state_id|
    state_id.user = user

    state_id.state = Faker::Address.state
    state_id.expiration_date = Faker::Date.between('2020-01-01', '2025-12-31')
    state_id.remote_image_url = Faker::Placeholdit.image
  end

  MedicalRecommendation.find_or_create_by(number: Faker::IDNumber.valid) do |state_id|
    state_id.user = user

    state_id.issuer = 'Medical Recommendation Issuer'
    state_id.state = Faker::Address.state
    state_id.expiration_date = Faker::Date.between('2020-01-01', '2025-12-31')
    state_id.remote_image_url = Faker::Placeholdit.image
  end
end
