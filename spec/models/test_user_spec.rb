require 'rails_helper'

RSpec.describe TestUser, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(50) }
  end
end
