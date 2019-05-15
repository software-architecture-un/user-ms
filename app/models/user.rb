# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string
#  document        :string
#  age             :integer
#  gender          :string
#  reputation      :float
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
    
    ## Secure password ##
    
    has_secure_password

    ## Queries ##

    # Query that gets all the users
    def self.get_all_users
        self.all.select(:id, :name, :document, :age, :gender, :reputation, :email, :password_digest)
    end

    # Query that gets the user corresponding to the id
    def self.get_user_by_id(current_id)
        self.where(id: current_id).select(:id, :name, :document, :age, :gender, :reputation, :email, :password_digest).first
    end

    # Query that gets the user corresponding to the email
    def self.get_user_by_email(current_email)
        self.where(email: current_email).select(:id, :name, :document, :age, :gender, :reputation, :email, :password_digest).first
    end

    # Query that updates an existing user record in DB
    def self.update_user(user_params, id_user)
        user = self.where(id: id_user).select(:id, :name, :document, :age, :gender, :reputation, :email, :password_digest).first

        if user.update(user_params) # If the user was updated successfully
            return user # Return the updated user
        else
            return nil # Return null if the user was not updated
        end
    end

    # Query that deletes an existing user record in DB
    def self.delete_user(id_user)
        user = self.where(id: id_user).select(:id, :name, :document, :age, :gender, :reputation, :email, :password_digest).first

        if user.destroy # If the user was deleted successfully
            return user # Return the deleted user
        else
            return nil # Return null if the user was not deleted
        end
    end

    ## Associations ##



    ## Validations ##

    validates :name, presence: true, length: { in: 4..100 } # Name with 6-100 characters
    validates :document, presence: true, length: { in: 1..20 } # Document with 1-20 characters
    validates :age, presence: true, numericality: { only_integer: true,
        greater_than_or_equal_to: 1, less_than_or_equal_to: 140 } # Age between 1-140
    validates :gender, presence: true, length: { in: 1..10 } # Gender with 1-10 characters
    validates :reputation, presence: true, numericality: { greater_than_or_equal_to: 0, 
        less_than_or_equal_to: 5 } # Reputation between 0-5
    validates :email, presence: true, length: { in: 6..100 },
        format: { with: URI::MailTo::EMAIL_REGEXP } # Email with 6-100 characters and email format
    #validates :password_digest, presence: true, length: { minimum: 6 } # Password with at least 6 characters
end
