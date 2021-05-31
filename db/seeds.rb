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

Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
               code: 'RUBYBASIC', price: 10, instructor: i,
               enrollment_deadline: 1.day.ago)

c = Course.create!(name: 'Ruby on Rails', description: 'Um curso de Ruby on Rails',
                   code: 'RUBYRAILS', price: 20, instructor: i,
                   enrollment_deadline: 3.months.from_now)
c.banner.attach(io: File.open(Rails.root.join('spec/fixtures/ruby_on_rails.png')), filename: 'ruby_on_rails.png')
puts 'Cursos cadastrados'

Lesson.create!(name: 'Classes e Objetos I', duration: 0, description: 'Orientação a Objetos em Ruby - Parte I', course: c)
Lesson.create!(name: 'Monkey Patch', duration: 1, description: 'Uma aula sobre Monkey Patch', course: c)
Lesson.create!(name: 'Classes e Objetos III', duration: 20, description: 'Orientação a Objetos em Ruby - Parte III', course: c)
puts 'Aulas criadas'

u = User.create!(email: 'estudante@codeplay.com', password: '12345678')
puts 'Usuário criado'

Enrollment.create!(user: u, course: c, price: c.price)
puts 'Matrícula criada'