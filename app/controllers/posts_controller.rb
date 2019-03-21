class PostsController < ApplicationController
 before_action :set_post, only: [:destroy, :edit, :update, :show]


  def index
    @post = Post.new
    respond_to do |format| 
      if !params[:buscador].nil? 
        if params[:buscador].blank?
          @posts = Post.all
        else 
          @posts = Post.where('title LIKE ?', "%#{params[:buscador]}%")       
        end
        format.js
      else 
        @posts = Post.all
        format.html
      end

    end 
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
      respond_to do |format|
        if @post.save
          format.js
        else
          format.html {redirect_to posts_path, alert: 'Intente de nuevo'} 
        end 
      end
    
  end

  def show 
    @post = Post.find(params[:id])
    @comments =  @post.comment
  end

  def edit 
    respond_to do |format|
      format.js
    end
  end

  def update 
    respond_to do |format|
      if @post.update(post_params) 
      format.js 
      else 
        format.html {redirect_to posts_path, alert: 'Error al actualizar'} 
      end
    end
  end

  def destroy
    @post.destroy 
    respond_to do |format|
      format.js
    end
  end
  
  private

  def set_post
    @post = Post.find(params[:id])
  end
  

  def post_params 
    params.require(:post).permit(:title, :content)
  end
end
