class InviteMailer < ApplicationMailer
  default from: "garth@elbowroomstudios.com"
  
  def invite_email(user, group)
    @user = user
    @group = group
    mail(to: @user.email, subject: 'You have been invited to lunch')
  end
end
