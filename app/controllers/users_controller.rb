class UsersController < ApplicationController
before_action :set_user

def show
	@posts = @user.posts.paginate(page: params[:page])
end

private

def check_user
   unless (@user == current_user) || (current_user.admin?)
   redirect_to root_url, alert: "You are not authorized"
 end
end

def set_user
	@user = User.find(params[:id])
end

end