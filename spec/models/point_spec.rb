require 'rails_helper'

describe Point do
  context 'attributes' do
    it { should validate_length_of(:message).is_at_least(1) }
    it { should validate_length_of(:clue).is_at_least(1) }
    it { should validate_length_of(:address).is_at_least(1) }
    it { should validate_length_of(:location).is_at_least(1) }
  end
end
