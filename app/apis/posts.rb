module API
 class Posts < Grape::API  
  def self.index
    Post.all
  end

  def self.create(post)    
    post = Post.new(post.to_h)
     if post.valid?
      post.save    
     
      return { 
        :data => post, 
        :status=>201,
        :message => "Post created Successfully"}
     else
      return {
        :error_code => 404, 
        :errors => post.errors.full_messages}
    end
 end

  def self.show(id)
    Post.find(id)
  end 

 end
end