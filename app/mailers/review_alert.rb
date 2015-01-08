class ReviewAlert < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.review_alert.notification.subject
  #
  def notification(review)
    @buddy = review.buddy.title
    @user = review.user.display_name
    @comment = review.comment
    mail to: review.buddy.user.email,
        subject: "New Review Posted"
  end
end
