require 'rails_helper'

RSpec.describe Topic, type: :model do

  context 'association' do
    it {should have_many(:posts)}
    it {should belong_to(:user)}
  end

  context "title and description validation" do
    it {should validate_length_of(:title)}
    it {should validate_presence_of(:title)}
    it {should validate_length_of(:description)}
    it {should validate_presence_of(:description)}
  end

  context 'slug-callback' do
    it 'should set slug' do
      topic = create(:topic)

      expect(topic.title.gsub(" ", "-")).to eql(topic.slug)
    end
  end

  context 'slug-update' do
    it 'should update slug' do
      topic = create(:topic)
      topic.update(title: "bobby")

      expect(topic.slug).to eql("bobby")
    end
  end

end
