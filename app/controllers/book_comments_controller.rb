# frozen_string_literal: true

class BookCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.book_comments.new(comment_params)
    @comment.book_id = params[:book_id]
    @comment.save
  end

  def destroy
    comment = BookComment.find(params[:id])
    @book = comment.book
    return unless current_user == comment.user

    comment.destroy
  end

  private

  def comment_params
    params.require(:book_comment).permit(:body)
  end
end
