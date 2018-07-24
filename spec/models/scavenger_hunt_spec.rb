require 'rails_helper'

describe ScavengerHunt do
  context 'attributes' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
  end
end
