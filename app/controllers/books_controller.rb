# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :authenticate_user!, only: %i[create edit update destroy index]

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    screen_user(@book)
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to @book
    else
      @books = Book.all
      render 'index'
    end
  end

  def update
    @book = Book.find(params[:id])
    screen_user(@book)
    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    screen_user(@book)
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def screen_user(book)
    redirect_to books_path unless book.user == current_user
  end
end
