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

  # context "image size validation" do
  #   it "should reject image larger than 1mb" do
  #     post = create(:post)
  #     extend ActionDispatch::TestProcess
  #     post.update(image: fixture_file_upload("bigcat.jpg"))
  #
  #     expect(post.errors.full_messages[0]).to eql("File size is too big. Please make sure it is 1MB or smaller.")
  #   end
  #
  #   it "should allow image smaller than 1mb" do
  #     post = create(:post)
  #     extend ActionDispatch::TestProcess
  #     post.update(image: fixture_file_upload("lindan.jpg"))
  # 
  #     expect(post.image).to be_present
  #     expect(post.image.file.size).to be <= 1.megabyte
  #   end
  # end

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
