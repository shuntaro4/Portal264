class NotificationMailer < ApplicationMailer
  default from: ENV['MAIL_ADDRESS']

  def send_confirm_to_user(reservation)
    @title  = reservation.concert.title
    @name   = reservation.name
    @ticket = reservation.ticket
    mail to: reservation.mail, bcc: ENV['MAIL_ADDRESS_ADMIN'], subject: 'ご予約ありがとうございます'
  end
end
