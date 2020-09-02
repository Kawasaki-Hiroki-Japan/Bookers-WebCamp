# frozen_string_literal: true

class SearchsController < ApplicationController
  before_action :authenticate_user!

  def search
    @book = Book.new
    content = params['search']['content']
    @model = params['search']['model']
    method = params['search']['method']
    case @model
    when 'book'
      @records = Book.search(content, method)
    when 'user'
      @records = User.search(content, method)
    end
  end
end
