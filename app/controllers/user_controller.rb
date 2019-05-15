class UserController < ApplicationController

    ## Filters ##



    ## Methods ##

    # Create a new user
=begin
    def create
        user = User.create_user(params_user) # Create a new user with the entered params

        if user != nil # If the user was created successfully
            render json: Responses.user_successfully_created(user)
        else # If the user was not created
            render json: Responses.bad_request
        end
    end
=end

    # GET /users
    # Show all the users
    def show
        users = User.get_all_users # Obtain all the users from the model

        if users.length > 0 # If exist at least one user in DB
            response = { content: users, mesagge: "Users has been obtained successfully" } # Return all the users

            render json: response, status: 200
        else # If not exist data
            response = { content: nil, message: "No users" }

            render json: response, status: 204 # Return 'no content' and nil
        end
    end

    # GET /users/:id
    # Show the user corresponding to the id
    def show_by_id
        user = User.get_user_by_id(params[:id]) # Obtain the user corresponding to the id

        if user != nil # If exist the user in DB
            response = { content: user, mesagge: "User has been obtained successfully" } # Return the corresponding user

            render json: response, status: 200
        else # If not exist data
            response = { error: "User not found" }

            render json: response, status: 404 # Return 'not found'
        end
    end

    # PATCH /users/:id
    # PUT /users/:id
    # Update an existing user
    def update
        user = User.update_user(params_user, params[:id]) # Update an existing user with the entered params

        if user != nil # If the user was updated successfully
            response = { content: user, mesagge: "User has been obtained successfully" } # Return the corresponding user

            render json: response, status: 200
        else # If the user was not updated
            response = { error: "User not found" }

            render json: response, status: 404 # Return 'not found'
        end
    end

    # DELETE /users/:id
    # Delete an existing user
    def delete
        user = User.delete_user(params[:id]) # Delete an existing user

        if user != nil # If the user was deleted successfully
            response = { content: user, mesagge: "User has been deleted successfully" } # Return the corresponding user

            render json: response, status: 200
        else # If the user was not destroyed
            response = { error: "User not found" }

            render json: response, status: 404 # Return 'not found'
        end
    end

    ## Allowed params ##

    def params_user
        params.permit(:id, :name, :document, :age, :gender, :reputation, :email, :password)
    end

end
