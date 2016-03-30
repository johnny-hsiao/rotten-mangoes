class UserMailer < ApplicationMailer
  default from: 'admin@example.com'

  def goodbye_email(user)
    @user = user
    @url = 'http://whatever.com/bye'
    mail(to: @user.email, subject: 'See you never')
  end
end
