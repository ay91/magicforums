require 'rails_helper'

RSpec.describe Post, type: :model do

  context 'association' do
    it {should have_many(:comments)}
    it {should belong_to(:user)}
    it {should belong_to(:topic)}
  end

  context "title and description validation" do
    it {should validate_length_of(:title)}
    it {should validate_presence_of(:title)}
    it {should validate_length_of(:body)}
    it {should validate_presence_of(:body)}
  end

  context 'slug-callback' do
    it 'should set slug' do
      post = create(:post)

      expect(post.title.gsub(" ", "-")).to eql(post.slug)
    end
  end

  context 'slug-update' do
    it 'should update slug' do
      post = create(:post)
      post.update(title: "bobby")

      expect(post.slug).to eql("bobby")
    end
  end

end
