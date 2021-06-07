require 'rails_helper'

describe 'Courses API' do
  context 'GET /api/v1/courses' do
    it 'should get courses' do
      capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

      Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                    code: 'RUBYBASIC', price: 10, instructor: capaldi,
                    enrollment_deadline: '22/12/2033')
      Course.create!(name: 'Ruby on Rails',
                    description: 'Um curso de Ruby on Rails',
                    code: 'RUBYONRAILS', price: 20, instructor: capaldi,
                    enrollment_deadline: '20/12/2033')

      get '/api/v1/courses'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.count).to eq(Course.count)
      expect(parsed_body[0]['name']).to include('Ruby')
      expect(parsed_body[1]['name']).to include('Ruby on Rails')
    end

    it 'return no courses' do
      get '/api/v1/courses'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body).to be_empty
    end
  end

  context 'GET /api/v1/courses/:code' do
    it 'should return a course' do
      capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

      Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                    code: 'RUBYBASIC', price: 10, instructor: capaldi,
                    enrollment_deadline: '22/12/2033')
      Course.create!(name: 'Ruby on Rails',
                    description: 'Um curso de Ruby on Rails',
                    code: 'RUBYONRAILS', price: 20, instructor: capaldi,
                    enrollment_deadline: '20/12/2033')

      get '/api/v1/courses/RUBYBASIC'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include('RUBYBASIC')
      expect(response.body).not_to include('RUBYONRAILS')
    end

    it 'should not found course by code' do
      get '/api/v1/courses/RUBYBASIC'

      expect(response).to have_http_status(404)
    end
  end

  context 'POST /api/v1/courses' do
    it 'should create a course' do
      capaldi = Instructor.create!(name: 'Peter Capaldi', email: 'peter@capaldi.com',
                                 bio: 'Twelfth Doctor')

      post '/api/v1/courses', params: { 
        course: { name: 'Ruby', code: 'RUBYBASIC', price: 10, instructor_id: capaldi.id }
      }

      expect(response).to have_http_status(201)
      expect(parsed_body['name']).to eq('Ruby')
      expect(parsed_body['code']).to eq('RUBYBASIC')
      expect(parsed_body['price']).to eq('10.0')
    end

    it 'should not create a course with invalid params' do
      post '/api/v1/courses', params: { 
        course: { name: 'Ruby' }
      }

      expect(response).to have_http_status(422)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['code']).to include('não pode ficar em branco')
      expect(parsed_body['price']).to eq(['não pode ficar em branco', 'não é um número'])
      expect(parsed_body['instructor']).to include('é obrigatório(a)')
    end

    it 'should not create a course with empty params' do
      post '/api/v1/courses', params: {}

      expect(response).to have_http_status(412)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['errors']).to include('paramêtros inválidos')
    end
  end

  private

  def parsed_body
    JSON.parse(response.body)
  end
end