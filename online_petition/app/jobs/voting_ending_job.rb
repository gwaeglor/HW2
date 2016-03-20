class VotingEndingJob < ActiveJob::Base
  @queue = :voting_ending_queue

  def self.perform(petition_id)
    Rails.logger.info '==========[ inside start ]'
        petition = Petition.find(petition_id)
        title = petition.title
        case
          when !(petition.win?) && (petition.become_expired?)
            UserMailer.apologize_petition_email(petition).deliver_now
            petition.update_attributes(title: '[closed]' + title.to_s)
        end
    end
    Rails.logger.info '==========[ inside end ]'
  end

