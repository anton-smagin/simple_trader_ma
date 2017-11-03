desc 'This task is called by the Heroku scheduler add-on'
task :shedule_trades => :environment do
  puts 'shedule_trades'
  next if %w[Saturday Sunday].include? Time.now.strftime('%A')
  (1..9).each do |min|
    TradersJob.set(wait: min.minute).perform_later
  end
  TradersJob.perform_now
  puts 'done.'
end
