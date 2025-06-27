require 'rails_helper'

RSpec.describe Course, type: :model do
  subject { build(:course) }

  describe 'associations' do
    it { is_expected.to have_many(:tutors).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:duration_hours) }
    it { is_expected.to validate_numericality_of(:duration_hours).is_greater_than(0) }
  end

  describe 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:tutors).allow_destroy(true) }
  end

  describe 'factory' do
    it 'creates a valid course' do
      course = build(:course)
      expect(course).to be_valid
    end

    it 'creates a course with tutors' do
      course = create(:course, :with_tutors)
      expect(course.tutors.count).to eq(2)
    end
  end

  describe 'dependent destroy' do
    it 'destroys associated tutors when course is destroyed' do
      course = create(:course, :with_tutors)
      tutor_ids = course.tutors.pluck(:id)

      course.destroy

      tutor_ids.each do |id|
        expect(Tutor.find_by(id: id)).to be_nil
      end
    end
  end
end
