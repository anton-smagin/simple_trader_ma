desc 'This task is called by the Heroku scheduler add-on'
task :shedule_trades => :environment do
  puts 'trades'
  next if %w[Saturday Sunday].include? Time.now.strftime('%A')
  TradersJob.perform_now
  puts 'done.'
end
