class SessionsController < ApplicationController
	def new
		@user = User.new
		render :new
	end

	def create
		username = params[:user][:username]
		password = params[:user][:password]

		user = User.find_from_credentials(username, password)

		if user
			sign_in(user)
			flash[:notice] = "Hi, #{username}! You signed in!"
			redirect_to things_route
		else
			flash[:error] = 'Username or password incorrect'
			@user = User.new(username: username)
			render :new
		end
	end

	def destroy
		sign_out
		flash[:notice] = 'You signed out!'
		redirect_to new_session_route
	end

	
end
