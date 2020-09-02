# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:user_id])
    redirect_to @user and return if @user == current_user

    @room = Room.entering(current_user, @user)
    @chat = Chat.new
    respond_to do |format|
      format.html
      format.json { @chats = @room.chats }
    end
  end
end
