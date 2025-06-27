require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe 'GET #index' do
    let!(:course1) { create(:course, :with_tutors) }
    let!(:course2) { create(:course, :with_tutors) }

    it 'returns all courses with their tutors' do
      get :index
      
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      
      expect(json_response.length).to eq(2)
      expect(json_response.first).to have_key('tutors')
      expect(json_response.first['tutors'].length).to eq(2)
    end

    it 'returns empty array when no courses exist' do
      Course.destroy_all
      
      get :index
      
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response).to eq([])
    end
  end

  describe 'GET #show' do
    let!(:course) { create(:course, :with_tutors) }

    it 'returns the specific course with tutors' do
      get :show, params: { id: course.id }
      
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      
      expect(json_response['id']).to eq(course.id)
      expect(json_response['name']).to eq(course.name)
      expect(json_response).to have_key('tutors')
      expect(json_response['tutors'].length).to eq(2)
    end

    it 'returns 404 when course not found' do
      get :show, params: { id: 99999 }
      
      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Course not found')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          course: {
            name: 'Ruby on Rails',
            description: 'Learn Ruby on Rails framework',
            duration_hours: 40,
            tutors_attributes: [
              {
                name: 'John Doe',
                email: 'john@example.com',
                phone: '1234567890',
                experience_years: 5
              },
              {
                name: 'Jane Smith',
                email: 'jane@example.com',
                phone: '0987654321',
                experience_years: 3
              }
            ]
          }
        }
      end

      it 'creates a new course with tutors' do
        expect {
          post :create, params: valid_params
        }.to change(Course, :count).by(1).and change(Tutor, :count).by(2)
        
        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        
        expect(json_response['name']).to eq('Ruby on Rails')
        expect(json_response['tutors'].length).to eq(2)
      end

      it 'returns the created course with tutors in response' do
        post :create, params: valid_params
        
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('id')
        expect(json_response).to have_key('tutors')
        expect(json_response['tutors'].first).to have_key('name')
        expect(json_response['tutors'].first).to have_key('email')
      end
    end

    context 'with invalid course parameters' do
      let(:invalid_params) do
        {
          course: {
            name: '',
            description: '',
            duration_hours: -1
          }
        }
      end

      it 'does not create a course' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Course, :count)
        
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns validation errors' do
        post :create, params: invalid_params
        
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('errors')
        expect(json_response['errors']).to be_an(Array)
        expect(json_response['errors']).not_to be_empty
      end
    end

    context 'with invalid tutor parameters' do
      let(:invalid_tutor_params) do
        {
          course: {
            name: 'Valid Course',
            description: 'Valid description',
            duration_hours: 40,
            tutors_attributes: [
              {
                name: '',
                email: 'invalid_email',
                phone: '',
                experience_years: -1
              }
            ]
          }
        }
      end

      it 'does not create course or tutors when tutor data is invalid' do
        expect {
          post :create, params: invalid_tutor_params
        }.not_to change(Course, :count)
        
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with duplicate tutor email' do
      let!(:existing_tutor) { create(:tutor, email: 'duplicate@example.com') }
      
      let(:duplicate_email_params) do
        {
          course: {
            name: 'New Course',
            description: 'Course description',
            duration_hours: 30,
            tutors_attributes: [
              {
                name: 'New Tutor',
                email: 'duplicate@example.com',
                phone: '1234567890',
                experience_years: 2
              }
            ]
          }
        }
      end

      it 'does not create course when tutor email is duplicate' do
        expect {
          post :create, params: duplicate_email_params
        }.not_to change(Course, :count)
        
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include('Tutors email has already been taken')
      end
    end
  end
end
