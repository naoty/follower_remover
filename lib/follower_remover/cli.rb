require "thor"

module FollowerRemover
  class CLI < Thor
    desc "start", "Start removing your followers"
    def start
      Remover.new.start
    end
  end
end