class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  
    # comments_controller.rb
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params) 
    @comment.user = current_user

    if @comment.save
      # ... 成功時の処理
    else
      flash.now[:alert] = "コメントを入力してください"
      @comments = @post.comments.includes(:user)
      render "posts/show"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    post = @comment.post   # 削除後に戻る投稿を取得

    if @comment.user == current_user || current_user&.admin?
      @comment.destroy
      redirect_to post_path(post), notice: "コメントを削除しました"
    else
      redirect_to post_path(post), alert: "削除権限がありません"
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
