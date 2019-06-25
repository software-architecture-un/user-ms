# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#                     login POST   /login(.:format)                                                                         auth#token
#                     users GET    /users(.:format)                                                                         user#show
#                           GET    /users/:id(.:format)                                                                     user#show_by_id {:id=>/[0-9]+/}
#                           PATCH  /users/:id(.:format)                                                                     user#update {:id=>/[0-9]+/}
#                           PUT    /users/:id(.:format)                                                                     user#update {:id=>/[0-9]+/}
#                           DELETE /users/:id(.:format)                                                                     user#delete {:id=>/[0-9]+/}
#                           GET    /*unmatched_route(.:format)                                                              application#route_not_found
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  ## Auth endpoints ##

  post 'login' => "auth#token" #  Return JWT (GET)
  post 'verify_token' => 'auth#verify' # Verify if JWT is true or not

  ## User endpoints ##
 
  post 'signup' => 'user#create' # Create a new user (POST) 
  get 'users' => 'user#show' # Return all the user (GET)
  get 'users/:id' => 'user#show_by_id', constraints: { id: /[0-9]+/ } # Return the user corresponding to the id (GET)
  post 'users_by_email' => 'user#show_by_email' # Show the user corresponding to the email (GET)
  patch 'users/:id' => 'user#update', constraints: { id: /[0-9]+/ } # Update an existing user (PATCH)
  put 'users/:id' => 'user#update', constraints: { id: /[0-9]+/ } # Update an existing user (PUT)
  delete 'users/:id' => 'user#delete', constraints: { id: /[0-9]+/ } # Delete an existing user (DELETE)

  ## Handle routes exceptions ##
  
  get '*unmatched_route' => 'application#route_not_found' # Handle the exceptions associates to not find the requested route (GET)

end
