class Users::Summary < ApplicationRecord
  belongs_to :user
end
# Don't make "user/summary". It has a duplicate error => user.rb file and user directory.
