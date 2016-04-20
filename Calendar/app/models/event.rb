class Event < ActiveRecord::Base
  has_many :posts
  belongs_to :calendar
end
