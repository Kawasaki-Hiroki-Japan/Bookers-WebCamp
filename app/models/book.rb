# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  has_many :favorites, dependent: :delete_all
  has_many :book_comments, dependent: :delete_all

  def favorited_by?(user)
    Favorite.where(user_id: user.id, book_id: id).exists?
  end

  def self.search(content, method)
    case method
    when 'perfect'
      where(title: content)
    when 'forward'
      where('title LIKE ?', "#{content}%")
    when 'backward'
      where('title LIKE ?', "%#{content}")
    when 'partial'
      where('title LIKE ?', "%#{content}%")
    end
  end
end
