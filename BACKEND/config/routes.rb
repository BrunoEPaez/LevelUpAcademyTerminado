Rails.application.routes.draw do
  # 1. RUTA RAÍZ
  # Esta ruta es vital para que Render confirme que la app está online.
  # Apuntamos a la lista de cursos del API como página de inicio por defecto.
  root to: "api/courses#index"

  # --- Rutas heredadas de la base de empleos ---
  resources :jobs
  resources :favorites, only: [:index, :create]
  delete 'favorites', to: 'favorites#destroy'
  resources :applications, only: [:index, :create]
  delete 'applications', to: 'applications#destroy'
  get '/my_job_applications', to: 'applications#index_for_my_jobs'

  # --- API NAMESPACE (Frontend React) ---
  namespace :api, defaults: { format: :json } do
    # Autenticación
    post 'register', to: 'users#create'
    post 'login', to: 'sessions#create'

    # Perfil de Usuario
    get 'profile', to: 'profiles#show'
    patch 'profile', to: 'profiles#update'
    delete 'profile', to: 'profiles#destroy'

    # Cursos, Lecciones y Progreso
    resources :courses, only: [:index, :show] do
      resources :lessons, only: [:index, :show] do
        # Ruta: /api/courses/:course_id/lessons/:id/complete
        member do
          post 'complete', to: 'progresses#complete'
        end
      end
    end
    
    # Rutas adicionales de progreso (UserCourses)
    post 'progress', to: 'user_courses#update'
    get 'progress', to: 'user_courses#index'
    get 'my_progress', to: 'progresses#index'
  end

  # Devise para el modelo User
  # Se mantienen los skips para manejar las sesiones vía API (JWT o similar)
  devise_for :users, skip: [:sessions, :registrations]
end