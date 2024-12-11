FactoryBot.define do
  factory :video do
    title { "RubyOnRuby" }
    description { "Initial Description" }
    cover { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpg'), 'image/jpg') }
    video_url { "https://www.youtube.com/watch?v=edm-Fcxq_bA&t=1266s" }
  end
end
