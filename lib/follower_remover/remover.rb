require "twitter"

module FollowerRemover
  class Remover
    def initialize
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV["CONSUMER_KEY"]
        config.consumer_secret = ENV["CONSUMER_SECRET"]
        config.access_token = ENV["ACCESS_TOKEN"]
        config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
      end
    end

    def start
      @following_ids = @client.friend_ids.to_a
      @followers = @client.followers(count: 200)
      @followers.each do |follower|
        next if @following_ids.include?(follower.id)
        begin
          @client.block(follower)
          @client.unblock(follower)
        rescue
          binding.pry
        end
      end
    end
  end
end