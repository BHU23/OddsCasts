require "rails_helper"
require_relative "../support/shared_examples/contents_spec.rb"

# describe "Videos management" do
#   let!(:video) { create(:video, title: "rubyonruby", description: "Initial Description", video_url: "https://www.youtube.com/watch?v=edm-Fcxq_bA&t=1266s") }
#   it_should_behave_like "Contents" do
#     let(:contentables) { "Videos" }
#     let(:contentable) { "Video" }
#     let(:content) { video }
#     let(:admin_content_path) { admin_videos_path }
#     let(:content_path) { admin_video_path(video) }
#     let(:content_edit_path) { edit_admin_video_path(video) }
#   end

#   scenario "Admin allows creating an video" do
#     visit_admin_page
#     click_link_new_video
#     fill_in_video_details
#     click_button_create
#     user_should_see_an_video
#   end

#   scenario "Admin sees videos on screen " do
#     visit_admin_page
#     user_should_see_videos
#   end

#   # scenario "Admin allows editing an article" do
#   #   visit_admin_page
#   #   user_selects_an_article
#   #   user_selects_an_article_to_edit
#   #   fill_in_article_new_details
#   #   user_saves_that_article
#   #   user_edited_the_article
#   # end

#   # scenario "Admin allows deleting an article" do
#   #   visit_admin_page
#   #   user_selects_an_article
#   #   user_destroy_the_article
#   #   user_should_see_the_article_is_deleted
#   # end

#   def visit_admin_page
#     visit admin_videos_path
#   end

#   # def user_selects_an_article
#   #   # Use the created article's path
#   #   visit admin_article_path(article)
#   # end

#   def click_link_new_video
#     # click_on('New')
#     visit new_admin_video_path
#   end

#   # def user_destroy_the_article
#   #   click_on('Destroy this article')
#   # end

#   # def user_selects_an_article_to_edit
#   #   click_on('Edit this article')
#   # end

#   def fill_in_video_details
#     fill_in("Title", :with => "RubyOnRuby")
#     fill_in("Description", :with => "Our Flat Organization Software Development Department")
#     attach_file('Cover', './spec/fixtures/files/test_image.jpg')
#     fill_in('Video url', :with => "https://www.youtube.com/watch?v=edm-Fcxq_bA&t=1266s")
#   end

#   # def fill_in_article_new_details
#   #   fill_in("Title", :with => "RubyOnRuby1")
#   #   fill_in("Description", :with => "Our Flat Organization Software Development Department")
#   #   attach_file('Cover', './spec/fixtures/files/test_image.jpg')
#   # end

#   def click_button_create
#     click_on("Create Video")
#   end

#   def user_should_see_an_video
#     expect(page).to have_content("RubyOnRuby")
#   end

#   def user_should_see_videos
#     expect(page).to have_css("video[src*='https://www.youtube.com/watch?v=edm-Fcxq_bA&t=1266s']")
#   end

#   # def user_saves_that_article
#   #   click_on("Update Article")
#   # end

#   # def user_edited_the_article
#   #   expect(page).to have_content("RubyOnRuby1")
#   # end

#   # def user_should_see_the_article_is_deleted
#   #   expect(page).not_to have_content("RubyOnRuby")
#   # end
# end
