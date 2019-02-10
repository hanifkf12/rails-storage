class Article < ApplicationRecord
  has_one_attached :poster, dependent: :destroy
end
