require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'relations' do
    it { should belong_to(:user) }
    it { should have_many(:expenses) }
  end

  context 'validations' do
    describe '#description' do
      it { should validate_presence_of(:description) }
    end
  end

  describe '#to_response' do
    context 'when the category have no parent or childs' do
      let(:category) { create(:category) }

      it do
        expect(category.to_response).to include('id' => category.id)
          .and include('description' => category.description)
      end
    end

    context 'when the category have childs' do
      let(:child_category) { create(:category) }
      let(:category) { create(:category, child_categories: [child_category]) }

      let(:expected_response) do
        {
          'id' => category.id,
          'description' => category.description,
          'parent_category_id' => nil,
          'child_categories' => [
            {
              'id' => child_category.id,
              'description' => child_category.description,
              'parent_category_id' => category.id
            }
          ]
        }
      end

      it { expect(category.to_response).to eq expected_response }
    end

    context 'when the category have a parent' do
      let(:parent_category) { create(:category) }
      let(:category) { create(:category, parent_category: parent_category) }

      let(:expected_response) do
        {
          'id' => category.id,
          'description' => category.description,
          'parent_category_id' => parent_category.id,
          'parent_category' => {
            'id' => parent_category.id,
            'description' => parent_category.description,
            'parent_category_id' => nil
          },
          'child_categories' => []
        }
      end

      it { expect(category.to_response).to eq expected_response }
    end
  end
end
