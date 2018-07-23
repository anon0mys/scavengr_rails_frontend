require 'rails_helper'

describe User do
  context 'attributes' do
    it { should validate_presence_of :username }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end
end
