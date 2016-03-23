require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
set :path, Rails.root
set :output, Rails.root.join('log', 'cron.log')

every 1.day, :at => '00:01 am'  do
  Rails.logger.info '####### SCHEDULE start'
  Petition.expired.each do |petition|
    Rails.logger.info '####### start processing petition'
    VotingEndingJob.perform(petition.id)
    Rails.logger.info '####### end processing petition'
  end
  Rails.logger.info '####### SCHEDULE end'
end

