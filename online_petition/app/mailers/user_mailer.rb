class UserMailer < ApplicationMailer
  default from: 'nn24090@gmail.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def winner_petition_email(petition)
    @petition = petition
    @user = @petition.user
    mail(to: @user.email, subject: 'Congratulations!')
  end

  def petition_voted_by_email(petition)
    @petition = petition
    @user = @petition.user
    mail(to: @user.email, subject: '+1 vote!')
  end

  def admin_winner_petition_email(petition)
    @petition = petition
    mail(to: ENV['gmail_username'], subject: 'Reminder')
  end

  def apologize_petition_email(petition)
    @petition = petition
    @user = @petition.user
    mail(to: @user.email, subject: 'Notification')
  end
end
