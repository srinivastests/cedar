require 'rails_helper'

RSpec.describe User, type: :model do
  it "should have many messages" do
    t = User.reflect_on_association(:messages)
    expect(t.macro).to eq(:has_many)
  end
    
    it 'should create user successfully' do 
      user = User.new(email: 'ruby@rails.com', password: 'ruby123').save
      expect(user).to eq(true)
    end    
end
