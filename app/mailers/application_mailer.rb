class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout 'mailer'
  def registration_confirmation(user)
  	@user = user
  	mail(:to => "#{user.username} <#{user.email}>"), :subject => "Register Confimation")
  end
end
