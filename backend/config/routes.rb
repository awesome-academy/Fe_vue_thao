Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Authentication
      post 'auth/sign_up', to: 'authentications#sign_up'
      post 'auth/login', to: 'authentications#login'
      post 'auth/verify-otp', to: 'authentications#verify_otp'
      post 'auth/resend-otp', to: 'authentications#resend_otp'
      post 'auth/forget-password', to: 'authentications#forget_password'
      post 'auth/google-login', to: 'authentications#google_login'
      
      # Admin
      get 'admin/pending-users', to: 'admins#pending_users'
      post 'admin/approve-user', to: 'admins#approve_user'
      post 'admin/reject-user', to: 'admins#reject_user'
      
      # Users
      resources :users
      resources :teachers
      resources :students
      resources :parents do
        resources :parent_student_links, only: [:index, :create, :destroy]
      end

      # Packages
      resources :packages, only: [:index, :show]

      # Classes
      resources :classes do
        # Leave Requests (nested under classes)
        resources :leave_requests, only: [:index, :create]
        # Enrollments (nested under classes)
        resources :enrollments, only: [:index, :create, :destroy]
        
        # Attendance Sessions (nested under classes)
        resources :attendance_sessions do
          resources :attendance_records, only: [:index, :create, :update]
        end
        
        # Assignments (nested under classes)
        resources :assignments do
          resources :submissions, only: [:index, :show, :create, :update]
        end
        
        # Transactions (nested under classes)
        resources :transactions, only: [:index, :create]
        # Student enrollment management routes
        get :student_class , on: :collection, to: 'class_enrollment#student_classes'
        post 'enroll', to: 'class_enrollment#enroll_class', on: :member
        get 'subjects', to: 'classes#subjects', on: :collection
        delete 'quit', to: 'class_enrollment#quit_class', on: :member
      end

      # Standalone resources
      resources :attendance_sessions, only: [:show]
      resources :attendance_records, only: [:show]
      resources :assignments, only: [:show]
      resources :assignment_attachments, only: [:index, :show, :create, :destroy]
      resources :submissions, only: [:show, :update]
      resources :transactions, only: [:show, :index]
      
      # Leave Requests
      resources :leave_requests, only: [:show, :update, :destroy] do
        patch :approve, on: :member
        patch :reject, on: :member
      end

      # AI Conversations
      resources :ai_conversations do
        resources :ai_messages, only: [:index, :create]
      end
    end
  end
end
