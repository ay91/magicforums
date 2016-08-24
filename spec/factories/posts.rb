FactoryGirl.define do
  factory :post do
    title "New title test"
    body "New Body test123"
    topic_id {create(:topic).id}
    user_id {create(:user, :sequenced_username, :sequenced_email).id}

    trait :with_image do
       image { fixture_file_upload("#{::Rails.root}/spec/fixtures/classroom.jpg") }
    end

    trait :sequenced_title do
      title
    end

    trait :sequenced_body do
      body
    end
  end
end
