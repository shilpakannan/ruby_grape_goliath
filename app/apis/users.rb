module API
  class Users < Grape::API
   def self.index
    User.all
   end

   def self.create(user)    
    user = User.new(user.to_h)
     if user.valid?
      user.save
      return { 
        :data => user, 
        :status=>201,
        :message => "User created Successfully"}
     else
      return {
        :error_code => 404, 
        :errors => user.errors.full_messages}
     end
    end

   def self.show(id)
    User.find(id)
   end

   def self.login(user)    
      email = user.email
      password = user.password

      if user.email.nil? or user.password.nil?
        return {
          :error_code => 404, 
          :errors => 'Invalid Username and Password'}             
        end
      user = User.find_by(email: email.downcase)
      if user.nil?
        return {
          :error_code => 404, 
          :errors => 'Invalid Username and Password'}              
        end
      if user && user.authenticate(password)
         key = ApiKey.create(user_id: user.id)
      {token: key.access_token}
    else
      return{:error_code => 401,
     :error_message => "Unauthorized"}
      
    end
    end 

  def self.destroy(key)    
    token = ApiKey.where(access_token: key).first
     user = User.find(token.user_id)
     if !user.nil?
     token.access_token = SecureRandom.hex
     token.save
      return
      {
      status: 'ok',
      message: 'User logged out'
      }
     else
     return{:error_code => 404,
     :error_message => "Invalid token."}
     end
    end     
  
        
  end
end
 