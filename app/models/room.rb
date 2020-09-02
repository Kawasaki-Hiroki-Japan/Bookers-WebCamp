# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :user_rooms, dependent: :delete_all
  has_many :chats, dependent: :delete_all

  def self.entering(current_user, another_user)
    another_user.user_rooms.each do |ur|
      next unless current_user.user_rooms.find_by(room_id: ur.room_id)

      return self.find(ur.room_id)
    end
    room = self.create
    UserRoom.create(room_id: room.id, user_id: current_user.id)
    UserRoom.create(room_id: room.id, user_id: another_user.id)
    return room
  end
end
