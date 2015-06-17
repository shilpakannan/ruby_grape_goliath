Dir["./app/models/*.rb"].each {|file| require file }
Dir["./app/apis/*.rb"].each {|file| require file }

class Routes < Grape::API
  version 'v1', :using => :path
  format :json 
  helpers do  
    def authenticate!
      error!('Unauthorized. Invalid or expired token.', 401) unless current_user
    end

    def current_user     
      # find token. Check if valid.
      token = ApiKey.where(access_token: params[:token]).first
      if token && !token.expired?
        @current_user = User.find(token.user_id)
      else
        false
      end
    end
end    
  resource 'posts' do   
    get "/" do      
      authenticate!
      API::Posts.index
    end    
    get "/:id" do 
      authenticate!
      API::Posts.show(params['id'])
    end    
    post "/create" do
      authenticate!
      API::Posts.create(params['post'])
    end
  end 
  
  
  resources :users do
    get "/" do
      authenticate!
      API::Users.index
    end    
    get "/:id" do 
      authenticate!
      API::Users.show(params['id'])
    end    
    post "/register" do
      API::Users.create(params['user'])
    end
    post "/login" do
      API::Users.login(params['user'])
    end
    delete 'logout' do
      authenticate!
     API::Users.destroy(params['token'])
    end
  end
    
  
end