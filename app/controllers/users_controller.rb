# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :screen_user, only: %i[edit update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def followings
    @book = Book.new
    @user = User.find(params[:id])
  end

  def followers
    @book = Book.new
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def map_display
    if current_user.is_display_map
      current_user.update(is_display_map: false)
    else
      current_user.update(is_display_map: true)
      current_user.latlng
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :email, :postal_code, :prefectures, :city, :street, :building)
  end

  def screen_user
    return if params[:id].to_i == current_user.id

    redirect_to current_user
  end
end
