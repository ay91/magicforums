FactoryGirl.define do
  factory :topic do
    title "new topic"
    description "new description"
    user_id {create(:user, :admin).id}

    trait :sequenced_title do
      title
    end

    trait :sequenced_description do
      description
    end

  end
end
