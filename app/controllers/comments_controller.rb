class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy, :edit, :update]
    def create
        @comment = Comment.new(comment_params)
        @comment.user = current_user
        @comment.post_id = params[:post_id]

        if @comment.save
          @post = params[:post_id]
            respond_to do |format|
              @comments = Comment.all()
              format.js 
            end
  
        else
            format.html {redirect_to posts_path, alert: 'Intente de nuevo'} 
        end
    end

    def edit
      @post = params[:post_id]
      respond_to do |format|
        format.js 
      end
    end
    

    def update
      respond_to do |format|
       if @comment.update(comment_params) 
        @post = params[:post_id]

        @comments =  @post.comment
        format.js 
       else 
        format.html {redirect_to posts_path, alert: 'Error al actualizar'} 
       end
      end
    end
    
    def destroy 
    @comment.destroy
    respond_to do |format|
      format.js 
    end
    end

    private

  def set_comment 
    @comment = Comment.find(params[:id])
  end
  

  def comment_params 
    params.require(:comment).permit(:content)
  end
end
