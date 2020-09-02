# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :book
  belongs_to :user
end
