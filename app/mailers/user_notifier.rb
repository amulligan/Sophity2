class UserNotifier < ActionMailer::Base
  default :from => 'The Sophity Team <admin@sophity.com>'
 
  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user, attach)
    @user = user
    attachments['SophityHealthCheckReport.pdf'] = attach
    mail( :to => @user.email,
    :subject => 'Health Check Request' )
  end

  def send_admin_report(user, attach)
  	@user = user
    attachments['SophityHealthCheckReport.pdf'] = attach
   mail( :to => 'amulligan@sophity.com',
    :subject => 'Health Check Request' )
  end
end