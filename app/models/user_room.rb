# frozen_string_literal: true

class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user_id, presence: true
  validates :room_id, presence: true
end
