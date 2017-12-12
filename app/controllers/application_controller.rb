class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

	def sign_in(user)
		token = SecureRandom.urlsafe_base64
		session[:session_token] = token
		user.update_attribute(:session_token, token)
	end

	def current_user
		token = session[:session_token]
		token && User.find_by(session_token: token)
	end

	def current_user
		@current_user ||= find_current_user
	end

	def find_current_user
		token = session[:session_toen]
		token && User.find_by(session_token: token)
	end

	def sign_out
		session.delete(:session_token)
		current_user.update_attribute(:session_token, nil)
	end

	def ensure_signed_in
		return if current_user
		flash[:error] = 'You must be signed in to see this.'
		redirect_to new_session_route
	end

	def ensure_signed_out
		return unless current_user
		flash[:error] = 'You are signed in, so you shouldn\' be here...'
		redirect_to things_route
	end
end
