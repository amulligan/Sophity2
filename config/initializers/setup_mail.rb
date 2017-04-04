ActionMailer::Base.smtp_settings = {
  :user_name => '',
  :password => '',
  :domain => 'smtp.gmail.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
ActionMailer::Base.default_url_options[:host] = "localhost:3000" 