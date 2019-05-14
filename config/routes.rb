Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  ## Auth endpoints ##

  post 'login' => "auth#token"

  ## Handle routes exceptions ##
  
  get '*unmatched_route' => 'application#route_not_found' # Handle the exceptions associates to not find the requested route (GET)

end
