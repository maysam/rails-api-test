# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }
  let(:state_id_id) { users.first.state_id.id }
  let(:medical_recommendation_id) { users.first.medical_recommendations.first.id }

  describe 'GET /users' do
    before { get '/users' }

    it 'returns users' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/:id' do
    before do
      Timecop.freeze('2019-01-01')

      get "/users/#{user_id}"
    end

    after do
      Timecop.return
    end

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns the associated state_id' do
        expect(json['state_id']).not_to be_empty
        expect(json['state_id']['id']).to eq(state_id_id)
      end

      it 'returns the associated medical_recommendations' do
        expect(json['medical_recommendations']).not_to be_empty
        expect(json['medical_recommendations'][0]['id']).to eq(medical_recommendation_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 99 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end

    context 'when the record\'s state_id is expired' do
      let!(:users) { [create(:user, state_id: build(:state_id, expiration_date: '2018-12-31'))] }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns an expired message' do
        expect(response.body).to match(/State ID is expired/)
      end
    end

    context 'when all record\'s medical_recommendation are expired' do
      let!(:users) do
        [create(:user, medical_recommendations:
          [build(:medical_recommendation, expiration_date: '2018-12-31')])]
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns an expired message' do
        expect(response.body).to match(/Medical Recommendation is expired/)
      end
    end

    context 'when one record\'s medical_recommendation is expired' do
      let!(:users) do
        [create(:user, medical_recommendations:
          [build(:medical_recommendation, expiration_date: '2018-12-31'),
           build(:medical_recommendation, expiration_date: '2019-01-02')])]
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /users' do
    let(:valid_attributes) { { name: 'John Doe', email: 'user@example.com', date_of_birth: '1989-01-01' } }

    context 'when the request is valid' do
      before { post '/users', params: valid_attributes }

      it 'creates a user' do
        expect(json['name']).to eq('John Doe')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/users', params: { name: 'John Doe', date_of_birth: '1989-01-01' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Email can't be blank/)
      end
    end

    context 'when state_id\'s attributes are included' do
      let(:state_id_attributes) do
        { number: '422-94-2421', state: 'Virginia',
          expiration_date: '2025-02-01', remote_image_url: 'https://via.placeholder.com/150' }
      end

      context 'when the request is valid' do
        before do
          params = valid_attributes.merge(state_id_attributes: state_id_attributes)

          post '/users', params: params
        end

        it 'creates an associated state_id' do
          expect(json['state_id']['number']).to eq('422-94-2421')
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when the request is invalid' do
        let(:state_id_attributes) do
          { number: '422-94-2421', state: 'Virginia', expiration_date: '2025-02-01' }
        end

        before do
          params = valid_attributes.merge(state_id_attributes: state_id_attributes)

          post '/users', params: params
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a validation failure message' do
          expect(response.body)
            .to match(/Validation failed: State id image can't be blank/)
        end
      end
    end

    context 'when medical_recommendation\'s attributes are included' do
      let(:medical_recommendations_attributes) do
        { number: '422-94-2421', issuer: 'Medical Recommendation Issuer',
          state: 'Virginia', expiration_date: '2025-02-01',
          remote_image_url: 'https://via.placeholder.com/150' }
      end

      context 'when the request is valid' do
        before do
          params = valid_attributes.merge(
            medical_recommendations_attributes: { '0' => medical_recommendations_attributes }
          )

          post '/users', params: params
        end

        it 'creates an associated medical_recommendation' do
          expect(json['medical_recommendations'][0]['number']).to eq('422-94-2421')
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when the request is invalid' do
        let(:medical_recommendations_attributes) do
          { number: '422-94-2421', issuer: 'Medical Recommendation Issuer',
            state: 'Virginia', expiration_date: '2025-02-01' }
        end

        before do
          params = valid_attributes.merge(
            medical_recommendations_attributes: { '0' => medical_recommendations_attributes }
          )

          post '/users', params: params
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a validation failure message' do
          expect(response.body)
            .to match(/Validation failed: Medical recommendations image can't be blank/)
        end
      end
    end
  end

  describe 'PUT /users/:id' do
    let(:valid_attributes) { { name: 'Jane Doe' } }

    before { put "/users/#{user_id}", params: valid_attributes }

    context 'when the record exists' do
      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 99 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
