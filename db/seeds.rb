# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

i = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com', bio: 'Twelfth Doctor')
i.profile_picture.attach(io: File.open(Rails.root.join('spec/fixtures/capaldi.jpg')), filename: 'capaldi.jpg' )
puts 'Instrutor cadastrado'

c = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10, instructor: i,
                   enrollment_deadline: '22/12/2033')
c.banner.attach(io: File.open(Rails.root.join('spec/fixtures/ruby_on_rails.png')), filename: 'ruby_on_rails.png')
puts 'Curso cadastrado'