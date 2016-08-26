require 'rails_helper'

RSpec.describe Comment, type: :model do

  context 'association' do
    it {should have_many(:votes)}
    it {should belong_to(:user)}
    it {should belong_to(:post)}
  end

  context "body validation" do
    it {should validate_length_of(:body)}
    it {should validate_presence_of(:body)}
  end

end
