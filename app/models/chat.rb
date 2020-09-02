# frozen_string_literal: true

class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :text, length: { maximum: 144, minimum: 1 }
end
