require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'validations' do
    describe '#name' do
      it { should validate_presence_of(:name) }
    end

    describe '#default' do
      subject(:account) { build(:account, user: user) }

      let(:user) { create(:user) }

      context 'when creating a record' do
        before { account.default = true }

        context 'whe the user already have an default account' do
          before do
            create(:account, default: true, user: user)
          end

          it 'does not create the record' do
            expect { account.save }.not_to change(Account, :count)
          end

          it 'account errors should include error on default field' do
            account.save
            expect(account.errors[:default]).to include('The user already have an default Account')
          end
        end

        context 'when the user does not have an default account' do
          it 'creates the record' do
            expect { account.save }.to change(Account, :count).by 1
          end
        end
      end

      context 'when updating a record' do
        before { account.save }

        context 'whe the user already have an default account' do
          before do
            create(:account, default: true, user: user)
          end

          it 'does not update the record' do
            expect(account.update(default: true)).to be_falsey
          end

          it 'account errors should include error on default field' do
            account.update(default: true)
            expect(account.errors[:default]).to include('The user already have an default Account')
          end
        end

        context 'when the user does not have an default account' do
          it 'updates the record' do
            expect(account.update(default: true)).to be_truthy
          end
        end
      end
    end
  end

  context 'relations' do
    it { should belong_to(:user) }
    it { should have_many(:reserves).class_name('Reserve') }
  end

  describe '#to_response' do
    subject { create(:account) }

    let(:expected_response) do
      {
        'id' => subject.id,
        'description' => subject.description,
        'name' => subject.name
      }
    end

    it { expect(subject.to_response).to eq expected_response }
  end
end
