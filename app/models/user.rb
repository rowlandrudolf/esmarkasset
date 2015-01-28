class User < ActiveRecord::Base
	has_secure_password 

	validates :email, :first_name, :last_name, presence: true

	class EmailValidator < ActiveModel::EachValidator
  	  def validate_each(record, attribute, value)
       record.errors.add attribute, (options[:message] || "is not an email") unless
         value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  	  end
	end

	validates :email, uniqueness: true, email: true 


	def full_name
	  [ first_name, last_name ].join(' ').titleize 
	end

private 


end
