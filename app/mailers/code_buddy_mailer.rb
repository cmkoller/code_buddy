class CodeBuddyMailer < ActionMailer::Base
  default from: "from@example.com"

  def review_posted(current_user, review)
    mail to: current_user.email,
      subject: 'Parking Confirmation'
  end

end
