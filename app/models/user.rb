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

    ## Associations ##



    ## Validations ##

    validates :name, presence: true, length: { in: 6..100 } # Name with 6-100 characters
    validates :document, presence: true, length: { in: 1..20 } # Document with 1-20 characters
    validates :age, presence: true, numericality: { only_integer: true,
        greater_than_or_equal_to: 1, less_than_or_equal_to: 140 } # Age between 1-40
    validates :gender, presence: true, length: { in: 1..10 } # Gender with 1-10 characters
    validates :reputation, presence: true, numericality: { greater_than_or_equal_to: 0, 
        less_than_or_equal_to: 5 } # Reputation between 0-5
    validates :email, presence: true, length: { in: 6..100 } # Email with 6-100 characters
    validates :password, presence: true, length: { in: 6..100 } # Password with 6-100 characters
end
