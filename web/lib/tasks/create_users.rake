# frozen_string_literal: true

namespace :users do
  desc 'Generate amount of users given in the task argument'
  task :generate_users, %i[amount team_name company_name] => :environment do |_task, args|
    args[:amount].to_i.times do |i|
      Rails.logger.info "Generating user ##{i + 1}"
      team = Team.find_by(name: args[:team_name]) || Team.create!(name: args[:team_name])
      company = Company.find_by(name: args[:company_name]) || Company.create!(name: args[:company_name])
      password = Faker::Alphanumeric.alpha(number: 10)
      user = User.create!(
        birth_date: Faker::Date.between(from: '1960-01-01', to: Time.zone.today),
        email: Faker::Internet.email,
        first_name: Faker::Name.last_name,
        is_admin: Faker::Boolean.boolean,
        last_name: Faker::Name.last_name,
        role: Faker::Job.position,
        password:,
        password_confirmation: password,
        company:,
        team:
      )
      profile_pic = random_picture
      user.profile_pictures.attach(**profile_pic) if profile_pic.present?
    end
  end
  def random_picture
    response = Faraday.get('https://this-person-does-not-exist.com/new')
    return nil unless response.success?

    domain = 'this-person-does-not-exist.com'
    parsed_body = JSON.parse(response.body)
    downloanded_img = URI.open("https://#{domain}/#{parsed_body['src']}")
    { io: downloanded_img, filename: parsed_body['name'] }
  end
end
