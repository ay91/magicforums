FactoryGirl.define do

  sequence :title do |x|
    "title-#{x}"
  end

  sequence :description do |x|
    "description-#{x}"
  end

  sequence :body do |x|
    "body-test-#{x}"
  end

end
