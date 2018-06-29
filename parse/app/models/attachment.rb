class Attachment < ApplicationRecord
  has_one_attached :file
  has_many :lines, dependent: :destroy
end
