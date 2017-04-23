class UserNotifier < ActionMailer::Base
  default :from => 'The Sophity Team <admin@sophity.com>'
 
  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Health Check Request' )
  end

  def send_admin_report(user)
  	@user = user
   mail( :to => 'amulligan@sophity.com',
    :subject => 'Health Check Request' )
  end
end