class ConfirmMailer < ApplicationMailer
  default from: ENV['MAIL_ADDRESS']

  def confirm_mail(reservation)
    @title  = reservation.concert.title
    @name   = reservation.name
    @ticket = reservation.ticket
    mail to: reservation.mail, subject: 'ご予約ありがとうございます'
  end
end
