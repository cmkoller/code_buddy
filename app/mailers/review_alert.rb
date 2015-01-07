class ReviewAlert < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.review_alert.notification.subject
  #
  def notification(review)
    @greeting = "There was a review posted on your Code Buddy, #{review.buddy.title}!"

    mail to: "#{review.buddy.user.email}"
  end
end
