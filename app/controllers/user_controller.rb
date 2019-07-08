class UserController < ApplicationController
    ## Require ##

    require 'httparty'

    ##  ##


    ## Include ##

    include HTTParty # HTTParty to check the Facebook Token

    ## Filters ##



    ## Methods ##

    # POST /signup
    # Creates a new user
    def create
        user = User.get_user_by_email(params[:email])

        if user == nil # If the user not exists
            user = User.new(params_user) # Create a new user with the entered params

            if user.save 
                user = User.get_user_by_id(user.id)

                ## Send notifications ##

                response = HTTParty.post("https://fcm.googleapis.com/fcm/send", 
                    :body =>
                    {
                        :notification =>
                        {
                            :title => 'Senderos UN',
                            :body => '¡Un nuevo usuario se ha unido a la comunidad!',
                            :click_action => '',
                            :icon => 'http://url-to-an-icon/icon.png'
                        },
                        :to => "/topics/senderos"
                    }.to_json,
                    :headers =>
                    {
                        'Content-Type' => 'application/json',
                        'AUthorization' => 'key=AAAA5DQn7-M:APA91bHq8UzsCvz8z-2nwVi8PgwDQEFgBQYqJLtzRsy1oz7bqFWYi83YjKiaBTXAMpn4CjUwII5YpQv9mVwG9gV6hrd5V3Q9-UGYbc39o_AfU-9YeFoyHqa1aeenhK7X68QTbHpypMjg'
                    }
                )

                ##  ##

                response = { content: user, message: "User has been created successfully", status: 201 } # Return the created user

                render json: response, status: 201
            else
                response = { content: {}, message: "Wrong Data", status: 400 }

                render json: response, status: 400 # Return 'bad request' and nil
            end
        else # If the user already exists
            response = { content: {}, error: "Email was already registered", status: 409 }

            render json: response, status: 409 # Return 'conflict' and nil
        end
    end

    # GET /users
    # Show all the users
    def show
        users = User.get_all_users # Obtain all the users from the model

        if users.length > 0 # If exist at least one user in DB
            response = { content: users, message: "Users has been obtained successfully", status: 200 } # Return all the users

            render json: response, status: 200
        else # If not exist data
            response = { content: [], message: "No users", status: 204 }

            render json: response, status: 204 # Return 'no content' and nil
        end
    end

    # GET /users/:id
    # Show the user corresponding to the id
    def show_by_id
        user = User.get_user_by_id(params[:id]) # Obtain the user corresponding to the id

        if user != nil # If exist the user in DB
            response = { content: user, message: "User has been obtained successfully", status: 200 } # Return the corresponding user

            render json: response, status: 200
        else # If not exist data
            response = { content: {}, message: "User not found", status: 404 }

            render json: response, status: 404 # Return 'not found'
        end
    end

    # POST /users_by_email
    # Show the user corresponding to the email
    def show_by_email
        user = User.get_user_by_email(params[:email]) # Obtain the user corresponding to the id

        if user != nil # If exist the user in DB
            response = { content: user, message: "User has been obtained successfully", status: 200 } # Return the corresponding user

            render json: response, status: 200
        else # If not exist data
            response = { content: {}, message: "User not found", status: 404 }

            render json: response, status: 404 # Return 'not found'
        end
    end

    # PATCH /users/:id
    # PUT /users/:id
    # Update an existing user
    def update
        user = User.update_user(params_user, params[:id]) # Update an existing user with the entered params

        if user != nil # If the user was updated successfully
            user = User.get_user_by_id(user.id)

            response = { content: user, message: "User has been updated successfully", status: 200 } # Return the corresponding user

            render json: response, status: 200
        else # If the user was not updated
            response = { content: {}, message: "User not found", status: 404 }

            render json: response, status: 404 # Return 'not found'
        end
    end

    # DELETE /users/:id
    # Delete an existing user
    def delete
        user = User.delete_user(params[:id]) # Delete an existing user

        if user != nil # If the user was deleted successfully
            response = { content: user, message: "User has been deleted successfully", status: 200 } # Return the corresponding user

            render json: response, status: 200
        else # If the user was not destroyed
            response = { content: {}, message: "User not found", status: 404 } 

            render json: response, status: 404 # Return 'not found'
        end
    end

    ## Allowed params ##

    def params_user
        params.permit(:name, :document, :age, :email, :password)
    end

end
