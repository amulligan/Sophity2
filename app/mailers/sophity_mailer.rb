class SophityMailer < ApplicationMailer
	default from: "info@sophity.com"

	def sample_email(user)
	    @user = user
	    mail(to: @user.email, subject: 'Sophity HealthCheck Report')
	  end
end
