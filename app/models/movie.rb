class Movie < ActiveRecord::Base
  def self.ratings
    ["NC-17", "G", "PG", "PG-13", "R"]
  end
end
