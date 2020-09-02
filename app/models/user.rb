# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  include JpPrefecture

  jp_prefecture :prefectures

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attachment :profile_image, destroy: false

  has_many :books
  has_many :favorites
  has_many :book_comments
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followee_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
  has_many :followings, through: :relationships, source: :followee
  has_many :user_rooms, dependent: :delete_all
  has_many :chats, dependent: :delete_all

  validates :name, presence: true, length: { maximum: 10, minimum: 2 }
  validates :introduction, length: { maximum: 50 }
  validates :postal_code, presence: true
  validates :prefectures, presence: true
  validates :city, presence: true
  validates :street, presence: true

  # enum prefectures: {
  #   hokkaido: 1,
  #   aomori: 2, iwate: 3, miyagi: 4, akita: 5, yamagata: 6, fukushima: 7,
  #   ibaraki: 8, tochigi: 9, gunma: 10, saitama: 11,
  #   chiba: 12, tokyo: 13, kanagawa: 14,
  #   niigata: 15, toyama: 16, ishikawa: 17, fukui: 18,
  #   yamanashi: 19, nagano: 20, gifu: 21, shizuoka: 22,
  #   aichi: 23, mie: 24, shiga: 25, kyoto: 26,
  #   osaka: 27, hyogo: 28, nara: 29, wakayama: 30,
  #   tottori: 31, shimane: 32, okayama: 33, hiroshima: 34,
  #   yamaguchi: 35, tokushima: 36, kagawa: 37, ehime: 38,
  #   kochi: 39, fukuoka: 40, saga: 41, nagasaki: 42,
  #   kumamoto: 43, oita: 44, miyazaki: 45, kagoshima: 46,
  #   okinawa: 47
  # }

  def following?(another_user)
    followings.include?(another_user)
  end

  def follow(another_user)
    return if self == another_user

    relationships.find_or_create_by(followee_id: another_user.id)
  end

  def unfollow(another_user)
    return if self == another_user

    relationship = relationships.find_by(followee_id: another_user.id)
    relationship&.destroy
  end

  def self.search(content, method)
    case method
    when 'perfect'
      where(name: content)
    when 'forward'
      where('name LIKE ?', "#{content}%")
    when 'backward'
      where('name LIKE ?', "%#{content}")
    when 'partial'
      where('name LIKE ?', "%#{content}%")
    end
  end

  def latlng
    return unless is_display_map

    begin
      Geocoder.search(prefectures + city).first.coordinates
    rescue
      update(is_display_map: false)
    end
  end
end
