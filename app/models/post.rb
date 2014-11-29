class Post < ActiveRecord::Base
	if Rails.env.development?
		has_attached_file :image, :styles => { :medium => "500x", :large => "1000x" }, :default_url => "default.jpg"
		validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] } 
	else
		has_attached_file :image, :styles => { :medium => "500x", :large => "1000x" }, :default_url => "default.jpg",
			:storage => :dropbox,
			:dropbox_credentials => Rails.root.join("config/dropbox.yml"),
			:path => ":style/:id_:filename"
		validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
	end

	searchkick

	default_scope -> {order('created_at DESC')}
	validates :content, presence: true, length: {maximum: 200}
	validates_attachment_presence :image

	belongs_to :user
	has_many :comments, dependent: :destroy
	acts_as_votable

	self.per_page = 10

	def score
		self.get_upvotes.size - self.get_downvotes.size
	end
	
end
