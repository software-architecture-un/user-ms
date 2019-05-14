class Token
    
    ## Variables ##

    $secret = Rails.application.secrets.secret_key_base # Secret key
    $algorithm = 'HS256' #SHA-256
    $expire = 7.days.from_now.to_i # Token expires in 7 days

    ## Methods ##

    # Create a new JWT, using data, expiration time, secret key and algorithm.
    def self.create_token(data)
        exp_payload = { data: data, exp: $expire } # Send data and expiration date
        current_token = JWT.encode exp_payload, $secret, $algorithm # Encode token with SHA-256

        return current_token
    end

    # Verify if the received token is valid
    def self.verify_token
        begin
            bearer_token = request.headers["Authorization"].split(" ") # Obtaint bearer token and split in an array
            JWT.decode(bearer_token[1], $secret) # Verify JWT (Second position of the array)
        rescue
            response = { status: 401, message: "Unauthorizated" } # If JWT is invalid, show authorization error
            render json: response
        end
    end
end