class AuthController < ApplicationController

    ## Filters ##



    ## Methods ##

    # POST /login
    # Login and generate JWT
    def token
        user = User.get_user_by_email(params[:email])

        if(user && user.authenticate(params[:password])) # If user exists and data is correct
            token = Token.create_token(user)

            response =  { jwt: token, mesagge: "User has been signed in successfully" } # Return JWT

            render json: response, status: 200
        else
            response =  { error: "Email or password wrong" }

            render json: response, status: 401 # Return 'unauthorizated' error
        end
    end

    ## Allowed params ##

    def params_user
        params.permit(:email, :password)
    end

end
