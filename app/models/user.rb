class User < ApplicationRecord
	validates :password, length: (8..99), allow_nil: true
	attr_reader :password

	def is_password?(password_attempt)
		BCrypt::Password.new(password_digest).is_password?(password_attempt)
	end

	def password=(raw_password)
		self.password_digest = BCrypt::Password.create(raw_password)
	end
	
	def self.find_form_credentials(username, password)
		user = find_by(username: username)
		return nil unless user
		user if user.is_password?(password)
	end


end
