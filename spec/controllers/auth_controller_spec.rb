require 'rails_helper'

RSpec.describe AuthController, type: :controller do
  describe 'POST #register' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          user: {
            email: 'test@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          }
        }
      end

      it 'creates a new user' do
        expect do
          post :register, params: valid_params
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
        json_response = response.parsed_body

        expect(json_response['message']).to eq('User registered successfully')
        expect(json_response['token']).to be_present
        expect(json_response['user']['email']).to eq('test@example.com')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          user: {
            email: 'invalid_email',
            password: 'short',
            password_confirmation: 'different'
          }
        }
      end

      it 'does not create a user' do
        expect do
          post :register, params: invalid_params
        end.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'POST #login' do
    let(:user) { create(:user, email: 'test@example.com', password: 'password123') }

    context 'with valid credentials' do
      let(:valid_params) do
        {
          email: 'test@example.com',
          password: 'password123'
        }
      end

      it 'returns a token and user info' do
        user # Create the user
        post :login, params: valid_params

        expect(response).to have_http_status(:ok)
        json_response = response.parsed_body

        expect(json_response['message']).to eq('Login successful')
        expect(json_response['token']).to be_present
        expect(json_response['user']['email']).to eq('test@example.com')
      end
    end

    context 'with invalid credentials' do
      let(:invalid_params) do
        {
          email: 'test@example.com',
          password: 'wrong_password'
        }
      end

      it 'returns unauthorized error' do
        user # Create the user
        post :login, params: invalid_params

        expect(response).to have_http_status(:unauthorized)
        json_response = response.parsed_body
        expect(json_response['error']).to eq('Invalid email or password')
      end
    end
  end
end
