class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  
    def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post), alert: "コメントできませんでした"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
