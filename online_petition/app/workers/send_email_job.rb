class SendEmailJob
  @queue = :send_email_queue
  def self.perform(petition_id)
    petition = Petition.find(petition_id)
    case
      when petition.win? && !(petition.become_expired?)
        UserMailer.winner_petition_email(petition).deliver_now
        UserMailer.admin_winner_petition_email(petition).deliver_now
      when !(petition.win?) && (petition.become_expired?)
        UserMailer.apologize_petition_email(petition).deliver_now
      else
        UserMailer.petition_voted_by_email(petition).deliver_now
    end
  end
end