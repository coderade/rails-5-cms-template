Rails.application.routes.draw do
  root 'demo#index'
  get 'demo/index'
  get 'demo/helo'

  get 'demo/other_hello'
  get 'demo/lynda'

  # default route
  # may go away in the future versions in Rails
  get ':controller(/:action(:/id))'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
