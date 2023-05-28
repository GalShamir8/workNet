# frozen_string_literal: true

namespace :posts do
  desc 'Generate amount of users given in the task argument'
  task :generate_posts, %i[amount] => :environment do |_task, args|
    args[:amount].to_i.times do
      User.all.sample(5).each do |u|
        args[:amount].to_i.times do
          post = Post.create!(description: Faker::Lorem.sentence, user_id: u.id)
          Posts::CalculatePostRank.new(post:).call
          img = random_picture
          post.attachments.attach(**img) if img.present?
        end
      end
    end
  end

  def random_picture
    img_url = Faker::LoremFlickr.image
    filename = img_url.split.last
    downloanded_img = URI.open(img_url)
    { io: downloanded_img, filename: }
  end
end
