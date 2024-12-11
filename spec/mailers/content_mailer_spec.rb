require "rails_helper"

RSpec.describe ContentMailer, type: :mailer do
  describe "notify_content_submitted" do
    let(:article) { create(:article) } 

    it "sends an email with the correct content" do
      mail = ContentMailer.with(content: article.content).notify_content_submitted

      expect(mail.subject).to eq("Request for Review: #{article.content.title} - Your Feedback Needed")
      expect(mail.body.encoded).to include("Welcome to OddsCasts, #{article.content.title}")
      expect(mail.body.encoded).to include("View Content")
    end
  end
end
