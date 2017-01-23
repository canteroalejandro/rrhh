Rails.application.routes.draw do


  get 'setting/root', as: :setting
  post 'setting/update', as: :setting_post

  resources :feriados
  resources :contratos
  resources :incidencias
  resources :hora_extras
  resources :roles
  resources :check_outs
  resources :check_ins
  resources :horarios
  resources :usuarios
  resources :proyectos
  resources :departamentos

  resources :empleados do
    get "asistencias_por_mes" => "asistencias#show_por_mes", as: "asistencias_por_mes"
    post "ajax_table_por_mes" => "asistencias#ajax_table_por_mes"

    get "asistencias_por_horas_extras" => "asistencias#show_por_horas_extras", as: "asistencias_por_horas_extras"
    post "ajax_table_por_horas_extras" => "asistencias#ajax_table_por_horas_extras"

    resources :asistencias
    resources :incidencia_empleados
    resources :contrato_empleados
    resources :historia_medicas
  end
  resources :horario_empleados
  resources :categorias
  resources :historia_medicas
  
  root :to => 'sessions#new'

  get "index" => "root#index", :as => "index"

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  resources :sessions

  resources :usuarios
  resources :categorias
  resources :proyectos
  resources :departamentos
  resources :empleados

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
