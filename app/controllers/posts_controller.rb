class PostsController < ApplicationController
  before_action :authenticate_user!,except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_exercise_log, only: [:new, :edit, :update]

 
  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
    @exercise_log = current_user.exercise_logs.find_by(date: Date.today)
  end

   def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.stage = current_user.current_stage            
    @post.cake_type_at_post = current_user.cake_type  

    # ▼▼既存のケーキ画像自動セット▼▼
    current_stage = current_user.total_points
    stage_index = User::GROWTH_STAGES[current_user.cake_type.to_sym].select { |s| s <= current_stage }.count
    prefix = current_user.cake_type == "shortcake" ? "cake" : "tart"
    formatted_index = format("%02d", stage_index)
    cake_path = Rails.root.join("app/assets/images/cakes/#{prefix}_stage_#{formatted_index}.png")
    @post.image.attach(io: File.open(cake_path), filename: "#{prefix}_stage_#{formatted_index}.png")

    if @post.save
      # -------------------------
      # 成長履歴自動保存ロジック
      # -------------------------

            # ▼ 成長履歴保存 ▼
      before_stage = current_user.current_stage
      current_user.growth_logs.create(growth_point: 1)
      after_stage = current_user.current_stage

      comment = after_stage != before_stage ? "🎉 ステージアップ！" : "🍰 今日の投稿！"

      GrowthRecord.create!(
        user: current_user,
        post: @post,
        stage: after_stage,
        date: Date.today,
        comment: comment
      )

      redirect_to @post, notice: "投稿しました🍰"
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

  def search
    @posts = Post.all

    if params[:exercise].present?
      @posts = @posts.joins(user: :exercise_logs)
                    .where(exercise_logs: { category: params[:exercise] })
                    .distinct  
    end

    if params[:cake_type].present?
      @posts = @posts.joins(:user).where(users: { cake_type: params[:cake_type] })
    end

    if params[:growth_status] == "finished"
      @posts = @posts.select { |post| post.user.growth_finished? }
    end

    render :index
  end

  private


  def post_params
    params.require(:post).permit(:exercise, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    unless @post.user == current_user
      redirect_to posts_path, alert: "投稿者しか編集できません"
    end
  end

  def set_exercise_log
    @exercise_logs = current_user.exercise_logs.where(date: Date.today)
  end

end