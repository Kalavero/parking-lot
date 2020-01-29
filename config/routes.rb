Rails.application.routes.draw do
  resource :parking, only: [:create]
end
