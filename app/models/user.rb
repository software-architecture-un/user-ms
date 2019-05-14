class User < ApplicationRecord
    
    ## Secure password ##
    
    has_secure_password

    ## Queries ##

    # Query that gets all the users
    def self.get_all_users
        self.all.select(:id, :name, :document, :age, :sex, :email)
    end

    # Query that gets the user corresponding to the id
    def self.get_user_by_id(current_id)
        self.where(id: current_id).select(:id, :name, :document, :age, :sex, :email).first
    end

    # Query that gets the user corresponding to the email
    def self.get_user_by_email(current_email)
        self.where(email: current_email).select(:id, :name, :document, :age, :sex, :email, :password_digest).first
    end
end
