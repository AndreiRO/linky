Rails.application.routes.draw do
 # You can have the root of your site routed with "root"
	root 'url_shortner#index'
  get '/:id' => 'url_shortner#index'
  post '/short' => 'url_shortner#short'
  get '/display/:id' => 'url_shortner#display'
end
