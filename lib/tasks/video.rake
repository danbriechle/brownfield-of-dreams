
namespace :videos do
  desc 'increment'
    task :increment => :environment do
       Video.increment_position
    end
end
