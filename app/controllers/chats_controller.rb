# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    @room = Room.entering(current_user, @user)
    @chat = current_user.chats.new(chat_params)
    @chat.room_id = @room.id
    @chat = Chat.new if @chat.save
  end

  def destroy
    chat = Chat.find(params[:id])
    @room = chat.room
    @room.user_rooms.each do |ur|
      @user = ur.user unless ur.user == current_user
    end
    chat.destroy
    @chat = Chat.new
  end

  private

  def chat_params
    params.require(:chat).permit(:text)
  end
end
