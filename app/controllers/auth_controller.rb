class AuthController < ApplicationController

    ## Filters ##

    ## Methods ##

    # POST /login
    # Login and generate JWT
    def token
        user = User.get_user_by_email(params[:email])

        if(user && user.authenticate(params[:password]))
            token = Token.create_token(user)

            response =  { jwt: token, mesagge: "User has been created successfully" }

            render json: response, status: 200
        else
            response =  { mesagge: "Email or password wrong" }

            render json: response, status: 401
        end
    end

    ## Allowed params ##

    def params_user
        params.permit(:email, :password)
    end

end
