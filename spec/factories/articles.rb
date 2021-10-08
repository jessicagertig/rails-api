FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "Sample Article #{n}" }
    content { "Sample content" }
    sequence(:slug) { |n| "sample-article#{n}" }
  end
end
