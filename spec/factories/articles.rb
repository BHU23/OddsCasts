FactoryBot.define do
  factory :article do
    title { "RubyOnRuby" }
    description { "Initial Description" }
    cover { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg'), 'image/jpg') }
    association :content, factory: :content, strategy: :build
  end
end
