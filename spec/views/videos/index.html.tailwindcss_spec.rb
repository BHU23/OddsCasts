require 'rails_helper'

RSpec.describe "videos/index", type: :view do
  before(:each) do
    assign(:videos, [
      Video.create!(
        title: "Title",
        description: "Description",
        video_url: "Video Url"
      ),
      Video.create!(
        title: "Title",
        description: "Description",
        video_url: "Video Url"
      )
    ])
  end

  it "renders a list of videos" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Description".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Video Url".to_s), count: 2
  end
end
