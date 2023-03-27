Rails.application.routes.draw do
  resources :merch_items do 
    collection do
      post 'check_price'
    end
  end
end
