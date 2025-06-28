require 'rails_helper'

RSpec.describe PaginationService do
  let(:courses) { create_list(:course, 25) }

  describe '#initialize' do
    it 'sets default values when no parameters provided' do
      service = described_class.new(Course.all)
      expect(service.send(:instance_variable_get, :@page)).to eq(1)
      expect(service.send(:instance_variable_get, :@per_page)).to eq(10)
    end

    it 'uses provided parameters' do
      service = described_class.new(Course.all, page: 2, per_page: 5)
      expect(service.send(:instance_variable_get, :@page)).to eq(2)
      expect(service.send(:instance_variable_get, :@per_page)).to eq(5)
    end

    it 'limits per_page to maximum value' do
      service = described_class.new(Course.all, per_page: 150)
      expect(service.send(:instance_variable_get, :@per_page)).to eq(100)
    end
  end

  describe '#paginate' do
    context 'with default pagination' do
      it 'returns first page with 10 items' do
        courses # Create the courses
        result = described_class.new(Course.all).paginate

        expect(result[:data].count).to eq(10)
      end

      it 'returns correct page and per_page for first page' do
        courses # Create the courses
        result = described_class.new(Course.all).paginate

        expect(result[:pagination][:page]).to eq(1)
        expect(result[:pagination][:per_page]).to eq(10)
      end

      it 'returns correct total count and pages for first page' do
        courses # Create the courses
        result = described_class.new(Course.all).paginate

        expect(result[:pagination][:total_count]).to eq(25)
        expect(result[:pagination][:total_pages]).to eq(3)
      end

      it 'returns correct navigation flags for first page' do
        courses # Create the courses
        result = described_class.new(Course.all).paginate

        expect(result[:pagination][:has_next]).to be true
        expect(result[:pagination][:has_prev]).to be false
      end
    end

    context 'with custom pagination' do
      it 'returns second page with 5 items' do
        courses # Create the courses
        result = described_class.new(Course.all, page: 2, per_page: 5).paginate

        expect(result[:data].count).to eq(5)
      end

      it 'returns correct page and per_page for second page' do
        courses # Create the courses
        result = described_class.new(Course.all, page: 2, per_page: 5).paginate

        expect(result[:pagination][:page]).to eq(2)
        expect(result[:pagination][:per_page]).to eq(5)
      end

      it 'returns correct total count and pages for second page' do
        courses # Create the courses
        result = described_class.new(Course.all, page: 2, per_page: 5).paginate

        expect(result[:pagination][:total_count]).to eq(25)
        expect(result[:pagination][:total_pages]).to eq(5)
      end

      it 'returns correct navigation flags for second page' do
        courses # Create the courses
        result = described_class.new(Course.all, page: 2, per_page: 5).paginate

        expect(result[:pagination][:has_next]).to be true
        expect(result[:pagination][:has_prev]).to be true
      end
    end

    context 'with last page' do
      it 'returns last page correctly' do
        courses # Create the courses
        result = described_class.new(Course.all, page: 3, per_page: 10).paginate

        expect(result[:data].count).to eq(5)
        expect(result[:pagination][:page]).to eq(3)
        expect(result[:pagination][:has_next]).to be false
        expect(result[:pagination][:has_prev]).to be true
      end
    end

    context 'with empty collection' do
      it 'handles empty collection' do
        result = described_class.new(Course.none).paginate

        expect(result[:data].count).to eq(0)
        expect(result[:pagination][:total_count]).to eq(0)
        expect(result[:pagination][:total_pages]).to eq(0)
        expect(result[:pagination][:has_next]).to be false
        expect(result[:pagination][:has_prev]).to be false
      end
    end
  end
end
