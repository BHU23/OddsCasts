require "rails_helper"

describe "Articles management" do
  let!(:article) { create(:article, title: "RubyOnRuby", description: "Initial Description") }

  scenario "Admin allows creating an article" do
    visit_admin_page
    click_link_new_article
    fill_in_article_details
    click_button_create
    user_should_see_an_article
  end

  scenario "Admin sees a list of articles" do
    visit_admin_page
    user_should_see_a_list_of_articles
  end

  scenario "Admin allows editing an article" do
    visit_admin_page
    user_selects_an_article
    user_selects_an_article_to_edit
    fill_in_article_details
    user_saves_that_article
    user_edited_the_article
  end

  scenario "Admin allows deleting an article" do
    visit_admin_page
    user_selects_an_article
    user_destroy_the_article
    user_should_see_the_article_is_deleted
  end

  def visit_admin_page
    visit admin_root_path
  end

  def user_selects_an_article
    # Use the created article's path
    visit admin_article_path(article)
  end

  def click_link_new_article
    # click_on('btn_new_articles')
    # click_on('New article')
    # find('new-article-btn').click
    visit new_admin_article_path
  end

  def user_destroy_the_article
    click_on('Destroy this article')
  end

  def user_selects_an_article_to_edit
    click_on('Edit this article')
  end

  def fill_in_article_details
    fill_in("Title", :with => "RubyOnRuby1")
    fill_in("Description", :with => "Our Flat Organization Software Development Department")
    attach_file('Cover', './spec/fixtures/files/test_image.jpg')
  end

  def click_button_create
    click_on("Create Article")
  end

  def user_should_see_an_article
    expect(page).to have_content("RubyOnRuby1")
  end

  def user_should_see_a_list_of_articles
    expect(page).to have_content("Articles")
    expect(page).to have_content(article.title)
    expect(page).to have_content(article.description)
    expect(page).to have_css("img[src*='test_image.jpg']")
  end

  def user_saves_that_article
    click_on("Update Article")
  end

  def user_edited_the_article
    expect(page).to have_content("RubyOnRuby1")
  end

  def user_should_see_the_article_is_deleted
    expect(page).not_to have_content(article.title)
  end
end
