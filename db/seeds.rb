# run seed file based on enviroment
puts 'Seeding database'
load(Rails.root.join('db', 'seeds', "#{Rails.env.downcase}.rb"))