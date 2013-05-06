Rails.application.routes.draw do
  resources :projects do
    resources :numbering_prefixes
    resources :numbering_items
  end
end
