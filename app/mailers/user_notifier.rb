class UserNotifier < ActionMailer::Base
  default :from => 'admin@sophity.com'
 
  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => 'andrastanciu212@gmail.com',
    :subject => 'Thanks for signing up for our amazing app' )
  end

  def send_admin_report(user)
  	@user = user
   mail( :to => 'amulligan@sophity.com',
    :subject => 'Sophity Healthcheck Report Request' )
  end
end