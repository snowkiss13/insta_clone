class Feed < ApplicationRecord
  mount_uploader :image, ImageUploader
end
