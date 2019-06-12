class AuthController < ApplicationController

    ## Filters ##



    ## Methods ##

    # POST /login
    # Login and generate JWT
    def token
        user = User.get_user_by_email(params[:email])

        if(user && user.authenticate(params[:password])) # If user exists and data is correct
            token = Token.create_token(user)

            response =  { content: token, message: "User has been signed in successfully", status: 201 } # Return JWT

            render json: response, status: 201
        else
            response =  { content: nil, message: "Authentication failed", status: 401 }
            render json: response, status: 401 # Return 'unauthorizated' error
        end
    end

    # POST /verify_token
    # Verify if JWT is valid or not
    def verify_jwt
        is_valid = Token.verify_token(params[:jwt])

        if(is_valid == true)
            response =  { content: is_valid, message: "JWT is valid", status: 200 } # Return JWT

            render json: response, status: 200
        else
            response =  { content: is_valid, message: "JWT is not valid", status: 400 } # Return JWT

            render json: response, status: 400
        end
    end

    ## Allowed params ##

    def params_user
        params.permit(:email, :password, :jwt)
    end

end
