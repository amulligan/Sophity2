ActionMailer::Base.smtp_settings = {
  :user_name => 'apikey',
  :password => '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',
  :domain => 'smtp.gmail.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
ActionMailer::Base.default_url_options[:host] = "localhost:3000" 