Rails.application.routes.draw do
  mount JobNotifier::Engine => "/job_notifier"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #post 'post/:id', action: collection_action
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
