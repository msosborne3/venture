class Post < ApplicationRecord
  belongs_to :place

  has_attached_file :post_photo, styles: { medium: "236x300#" }
  validates_attachment_content_type :post_photo, content_type: /\Aimage\/.*\z/
end
