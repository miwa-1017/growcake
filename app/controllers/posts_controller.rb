class PostsController < ApplicationController
  before_action :authenticate_user!,except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

 
  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    # 画像自動添付処理
    current_stage = current_user.total_points
    stage_index = User::GROWTH_STAGES[current_user.cake_type.to_sym].select { |s| s <= current_stage }.count

    # cake または tart 判定
    prefix = current_user.cake_type == "shortcake" ? "cake" : "tart"

    # 01,02...にゼロ埋め
    formatted_index = format('%02d', stage_index)

    cake_path = Rails.root.join("app/assets/images/cakes/#{prefix}_stage_#{formatted_index}.png")

    @post.image.attach(io: File.open(cake_path), filename: "#{prefix}_stage_#{formatted_index}.png")


    if @post.save
      redirect_to @post, notice: "投稿しました🎉"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "更新しました✨"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "削除しました🗑"
  end

  private


  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    unless @post.user == current_user
      redirect_to posts_path, alert: "投稿者しか編集できません"
    end
  end

end