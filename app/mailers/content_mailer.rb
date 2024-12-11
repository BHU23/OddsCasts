class ContentMailer < ApplicationMailer
    default from: "b6419455@g.sut.ac.th"
    layout "mailer"

    def notify_content_submitted
        @content = params[:content]
        mail(to: "ttthisriton29@gmail.com", subject: "Request for Review: #{@content.title} - Your Feedback Needed")
      end
end
