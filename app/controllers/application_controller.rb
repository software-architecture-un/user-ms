class ApplicationController < ActionController::API

    ## Exceptions ##

    # Handles the exception associates to not find the requested route
    def route_not_found
        response =  { error: "Route not found" }

        render json: response, status: 404 # Return 'not found'
    end

end
