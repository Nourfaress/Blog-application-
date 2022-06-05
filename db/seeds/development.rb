# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts 'Seeding development database...'
nour = User.first_or_create!(email: 'nour@ex.com',
                            password: 'password',
                            password_confirmation: 'password',
                            first_name: 'Nour',
                            last_name: 'Fares',
                            role: User.roles[:admin])

kim = User.first_or_create!(email: 'test@ex.com',
                                password: 'password',
                                password_confirmation: 'password',
                                first_name: 'Test',
                                last_name: 'Case')
Address.first_or_create!(street: '123 Main St',
                            city: 'Anytown',
                            state: 'Giza',
                            zip: '12345',
                            country: 'EG',
                            user: nour)
Address.first_or_create(street: '123 Main St',
                        city: 'Anytown',
                        state: 'CIB',
                        zip: '12345',
                        country: 'UK',
                        user: kim)

elapsed = Benchmark.measure do
    posts = []
    10.times do |x|
        puts "Creating post #{x}"
        post = Post.new(title: "No. #{x}",
                        body: "keep trying #{x} once more",
                        user: nour)

        5.times do |y|
        puts "Creating comment #{y} for post #{x}"
        comment = post.comments.build(body: "Comment #{y}",
                        user: kim)
        end
        posts.push(post)
    end
    Post.import(posts, recursive: true)
end

puts "Seeded development DB in #{elapsed.real} seconds"