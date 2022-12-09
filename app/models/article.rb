class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2, maximum: 100,
                                              too_long: '100 characters is the maximum allowed' }
  validates :body, presence: true, length: { minimum: 2, maximum: 3000,
                                             too_long: '3000 characters is the maximum allowed' }
  validates :user_id, presence: true

  belongs_to :user
end
