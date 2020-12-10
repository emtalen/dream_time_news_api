Rails.application.routes.draw do
  mount_devise_token_auth_for "Admin", at: "api/v2/auth", skip: [:omniauth_callbacks]

  namespace :api do
    namespace :v2 do
    end
  end
end
