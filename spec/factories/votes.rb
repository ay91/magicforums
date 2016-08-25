FactoryGirl.define do
  factory :vote do
    comment_id {create(:comment).id}
    user_id {create(:user, :sequenced_username, :sequenced_email).id}

    trait :up do
      value 1
    end

    trait :down do
      value -1
    end
  end
end
