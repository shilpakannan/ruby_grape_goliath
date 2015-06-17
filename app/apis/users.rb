require 'mail'
module API

  class Users < Grape::API
   def self.index
    User.all
   end

   def self.create(user)    
    user = User.new(user.to_h)
     if user.valid?
      user.save
      Mail.defaults do

  delivery_method :smtp, { 
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",  
  :user_name            => "shilpa92.kannan@gmail.com",
  :password             => "shilpakannan27",
  :authentication       => "plain",
  :enable_starttls_auto => true }

end
mail = Mail.deliver do
  to      'shilpa.k@optisolbusiness.com'
  from    'shilpa92.kannan@gmail.com'
  subject 'ruby POC'
  body    'Welcome to ruby'
  
end
     
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
 