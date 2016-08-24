FactoryGirl.define do
  factory :comment do
    body "New comment for test"
    post_id {create(:post).id}
    user_id {create(:user, :sequenced_email, :sequenced_username)}

    trait :sequenced_body do
      body
    end

  end
end
