class Destination < ApplicationRecord
    has_many :posts
    has_many :bloggers, through: :posts

    def recent_posts
        sorted_posts = self.posts.sort_by {|post| post.created_at}.reverse
        recent_posts = sorted_posts[0,5]
    end

    def featured_post
        featured_post = nil
        featured_post_likes = 0
        self.posts.each do |post|
            if post.likes > featured_post_likes                    
                featured_post = post
                featured_post_likes = post.likes
            end
        end
        featured_post
    end

    def average_age
        total_ages = 0
        self.bloggers.distinct.each do |blogger|
            total_ages += blogger.age
        end
        total_ages/self.bloggers.length
    end



end
