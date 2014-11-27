class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user
	default_scope -> {order('created_at DESC')}
	validates :body, presence: true, length: {minimum: 2, maximum: 200}
	validates :user_id, presence: true
	validates :post_id, presence: true

	self.per_page = 20
end
