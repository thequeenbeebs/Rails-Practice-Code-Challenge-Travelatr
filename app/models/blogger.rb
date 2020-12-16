class Blogger < ApplicationRecord
    has_many :posts
    has_many :destinations, through: :posts

    validates :name, uniqueness: true
    validates :age, numericality: {greater_than: 0}
    validates :bio, length: {minimum: 30}

    def total_likes
        total = 0
        self.posts.each do |post|
            total += post.likes
        end
        total
    end

    # using order by 
    def featured_post
        featured_post = self.posts[0]
        featured_post_likes = 0
        self.posts.each do |post|
            if post.likes > featured_post_likes
                featured_post = post
                featured_post_likes = post.likes
            end
        end
        featured_post
    end

    def top_five
        top_five = []
        all_destinations = self.destinations.clone
        5.times do
            if all_destinations.length >  0
                top_destination = all_destinations.max { |a, b| a.posts.length <=> b.posts.length }
                top_five << top_destination
                all_destinations.delete(top_destination)
            end
        end
        top_five
    end



end
