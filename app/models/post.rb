class Post < ActiveRecord::Base
	has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100" }, :default_url => "default.jpg"
	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] } 

	default_scope -> {order('created_at DESC')}
	validates :content, presence: true, length: {maximum: 200}
	validates_attachment_presence :image

	belongs_to :user
end
