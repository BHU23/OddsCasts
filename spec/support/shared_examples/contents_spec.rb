require "rails_helper"
require 'selenium-webdriver'
shared_examples "Contents", type: :system do
    let(:content) { create(content, title: contentable.title, description: contentable.description1) }
    let!(:restricted_words) do
      create(:restricted_word, word: "Fxxxxx")
      create(:restricted_word, word: "Sxxxxx")
      create(:restricted_word, word: "Bxxxxx")
    end
    
    scenario "Admin allows creating an content" do
        visit_admin_page
        click_link_new_content
        fill_in_content_details
        click_button_create
        user_should_see_an_content
      end
    
      scenario "Admin sees a list of contents" do
        visit_admin_page
        user_should_see_a_list_of_contents
      end
    
      scenario "Admin allows editing an content" do
        visit_admin_page
        user_selects_an_content
        user_selects_an_content_to_edit
        fill_in_content_new_details
        user_saves_that_content
        user_edited_the_content
      end
    
      scenario "Admin allows deleting an content" do
        visit_admin_page
        user_selects_an_content
        user_destroy_the_content
        user_should_see_the_content_is_deleted
      end

      scenario "user can submit the content for a review" do
        visit_admin_page
        user_selects_an_content
        user_selects_an_content_to_edit
        click_on "Submit for review"
        # expect(page).to have_content
      end

      scenario "user cannot use Fxxxxx, Sxxxxx, or Bxxxxx in the title text field" do
        # article = build(:article, title: "This is Fxxxxx, Sxxxxx, and Bxxxxx")
        # expect(article).not_to be_valid
        visit_admin_page
        click_link_new_content
        fill_in_title_details("This is Fxxxxx, Sxxxxx, and Bxxxxx")
        click_button_create
      
        user_sees_notices_that_text_is_restricted_word("Fxxxxx")
        user_sees_notices_that_text_is_restricted_word("Sxxxxx")
        user_sees_notices_that_text_is_restricted_word("Bxxxxx")
      end
    
      scenario "user cannot use title contains restricted words with different cases" do
        visit_admin_page
        click_link_new_content
        fill_in_title_details("This is fxxxxx and sxxxxx")
        click_button_create
        user_sees_notices_that_text_is_restricted_word("Fxxxxx")
        user_sees_notices_that_text_is_restricted_word("Sxxxxx")
      end
    
      scenario "user cannot submit with a blank title" do
        visit_admin_page
        click_link_new_content
        fill_in_title_details(" ")
        click_button_create
        user_sees_notification_for_error_message("Title can't be blank")
      end
      
      scenario "user cannot submit with a title shorter than 1 character" do
        visit_admin_page
        click_link_new_content
        fill_in_title_details("")
        click_button_create
        user_sees_notification_for_error_message("Title is too short (minimum is 1 character)")
        user_sees_notification_for_error_message("Title can't be blank")
      end      

      scenario "user uses title does not contain restricted words" do
        visit_admin_page
        click_link_new_content
        fill_in_title_details("This is a clean title")
        click_button_create
        user_sees_notices_created
      end
    
      scenario "user can use a restricted word is part of another word" do
        visit_admin_page
        click_link_new_content
        fill_in_title_details("This is notfxxxxxallowed")
        click_button_create
        user_sees_notices_created
      end

      def visit_admin_page
        visit admin_content_path
      end
    
      def user_selects_an_content
        # Use the created content's path
        visit content_path
      end
    
      def click_link_new_content
        click_on('New')
      end
    
      def user_destroy_the_content
        click_on("Destroy this #{contentable.downcase}")
      end
    
      def user_selects_an_content_to_edit
        click_on("Edit this #{contentable.downcase}")
      end
    
      def fill_in_content_details
        fill_in("Title", :with => "RubyOnRuby")
        fill_in("Description", :with => "Our Flat Organization Software Development Department")
        attach_file('Cover', './spec/fixtures/files/test_image.jpg')
      end
    
      def fill_in_content_new_details
        fill_in("Title", :with => "RubyOnRuby1")
        fill_in("Description", :with => "Our Flat Organization Software Development Department")
        attach_file('Cover', './spec/fixtures/files/test_image.jpg')
      end
    
      def click_button_create
        click_on("Create #{contentable}")
      end
    
      def user_should_see_an_content
        expect(page).to have_content("RubyOnRuby")
      end
    
      def user_should_see_a_list_of_contents
        expect(page).to have_content(contentable)
        expect(page).to have_content(content.title)
        expect(page).to have_content(content.description)
        expect(page).to have_css("img[src*='test_image.jpg']")
      end
    
      def user_saves_that_content
        click_on("Update #{contentable}")
      end
    
      def user_edited_the_content
        expect(page).to have_content("RubyOnRuby1")
      end
    
      def user_should_see_the_content_is_deleted
        expect(page).not_to have_content("RubyOnRuby")
      end

      def fill_in_title_details(title)
        fill_in("Title", :with => title)
      end

      def user_sees_notices_that_text_is_restricted_word(restricted_word)
        expect(page).to have_content("contains a restricted word: '#{restricted_word}'")
      end

      def user_sees_notification_for_error_message(error_message)
        expect(page).to have_content(error_message)
      end
      
      def user_sees_notices_created
        expect(page).to have_content("#{contentable} was successfully created.")
      end
  end
  