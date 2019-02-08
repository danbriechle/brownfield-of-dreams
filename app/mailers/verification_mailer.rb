class VerificationMailer < ApplicationMailer
  def verify(email, user)
    @user = user
    mail(to: email, subject: "Verify your account!")
  end 
end
