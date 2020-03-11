FactoryBot.define do
  factory :notification do
    user { nil }
    title { 'MyString' }
    url { 'MyString' }
    read { false }
  end
end
