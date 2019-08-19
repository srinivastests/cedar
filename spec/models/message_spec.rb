require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'Association tests' do 
      it "should belong to user" do
        t = Message.reflect_on_association(:user)
        expect(t.macro).to eq(:belongs_to)
      end      
  end      
    
  context 'validation tests' do 
    it 'ensures Content presence' do
      message = Message.new(content: 'Last').save
      expect(message).to eq(false)
    end
  end
    
end
