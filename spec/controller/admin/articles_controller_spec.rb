require 'rails_helper'

describe Admin::ArticlesController, type: :controller do
    it "sends an email when an article is submitted" do
        article = create(:article)
    
        expect(ContentMailer).to receive(:with).with(content: article.content).and_return(
            double(notify_content_submitted: double(deliver_now: true))
        )
    
        post :submit_for_review, params: { id: article.id }
    end
end
  