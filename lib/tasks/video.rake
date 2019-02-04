namespace :videos do
  desc 'increment'
    task :increment do
       Video.increment_position
    end
end
