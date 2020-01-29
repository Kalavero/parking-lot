Rails.application.routes.draw do
  resource :parking, only: [:create] do
    member do
      put '/:id/out', as: :out, action: :out
      put '/:id/pay', as: :pay, action: :pay
      get ':plate', as: :history, action: :history
    end
  end
end
