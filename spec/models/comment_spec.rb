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

  context 'total votes' do
    it 'should display total votes to be zero if no vote' do
      comment = create(:comment)
      expect(comment.total_votes).to eql(0)
    end

    it 'should calculate total vote correctly' do
      comment = create(:comment)
      user = create(:user)

      1.upto(10) do |x|
         user.votes.create(comment_id: comment.id, value: x%3 == 0? -1 : 1)
      end
      expect(comment.total_votes).to eql(4)
    end
  end
end
