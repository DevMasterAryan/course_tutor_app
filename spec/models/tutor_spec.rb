require 'rails_helper'

RSpec.describe Tutor, type: :model do
  subject { build(:tutor) }

  describe 'associations' do
    it { should belong_to(:course) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:experience_years) }
    it { should validate_numericality_of(:experience_years).is_greater_than_or_equal_to(0) }
    
    it 'validates email format' do
      tutor = build(:tutor, email: 'invalid_email')
      expect(tutor).not_to be_valid
      expect(tutor.errors[:email]).to include('is invalid')
    end
  end

  describe 'factory' do
    it 'creates a valid tutor' do
      tutor = build(:tutor)
      expect(tutor).to be_valid
    end
  end

  describe 'email uniqueness' do
    it 'does not allow duplicate emails' do
      create(:tutor, email: 'test@example.com')
      duplicate_tutor = build(:tutor, email: 'test@example.com')
      
      expect(duplicate_tutor).not_to be_valid
      expect(duplicate_tutor.errors[:email]).to include('has already been taken')
    end

    it 'does not allow case-insensitive duplicate emails' do
      create(:tutor, email: 'test@example.com')
      duplicate_tutor = build(:tutor, email: 'TEST@EXAMPLE.COM')
      
      expect(duplicate_tutor).not_to be_valid
      expect(duplicate_tutor.errors[:email]).to include('has already been taken')
    end
  end
end
