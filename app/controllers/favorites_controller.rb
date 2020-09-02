# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :authenticate_user!

  # POST /books/:book_id/favorites
  def create
    return unless Favorite.find_by(book_id: params[:book_id], user_id: current_user.id).nil?

    @favorite = current_user.favorites.new(book_id: params[:book_id])
    @favorite.save
  end

  # DELETE /books/:book_id/favorites/
  def destroy
    return if Favorite.find_by(book_id: params[:book_id], user_id: current_user.id).nil?

    @favorite = Favorite.find_by(user_id: current_user, book_id: params[:book_id])
    @favorite.destroy
  end
end
