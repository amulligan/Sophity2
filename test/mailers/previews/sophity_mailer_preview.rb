# Preview all emails at http://localhost:3000/rails/mailers/sophity_mailer
class SophityMailerPreview < ActionMailer::Preview
	def sample_mail_preview
    SophityMailer.sample_email(User.first)
  end
end
