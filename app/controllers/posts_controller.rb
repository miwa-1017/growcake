class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_exercise_log, only: [:new, :edit, :update]
  before_action :forbid_guest, only: [:new, :create, :edit, :update, :destroy]

 
  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
    @comments = @post.comments
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

    # ▼ ケーキ画像の自動セット ▼
    current_stage = current_user.total_points
    stage_index = User::GROWTH_STAGES[current_user.cake_type.to_sym]
                    .select { |s| s <= current_stage }.count
    prefix = current_user.cake_type == "shortcake" ? "cake" : "tart"
    formatted_index = format("%02d", stage_index)
    cake_path = Rails.root.join("app/assets/images/cakes/#{prefix}_stage_#{formatted_index}.png")
    @post.image.attach(io: File.open(cake_path), filename: "#{prefix}_stage_#{formatted_index}.png")

    # ▼ 今日の運動ログ（複数）を取得
    today_logs = current_user.exercise_logs.where(date: Date.today)

    if today_logs.present?
      exercises = today_logs.map do |log|
        jp_name = I18n.t("enums.exercise_log.category.#{log.category}")
        "#{jp_name}(#{log.minutes}分)"
      end

      @post.exercise = exercises.join("・")  # 「・」で区切って保存
    else
      @post.exercise = nil
    end

    # 検索用カテゴリの保存
    if today_logs.present?
      @post.search_categories = today_logs.map(&:category)
    else
      @post.search_categories = []
    end

   if @post.save
    before_stage = current_user.current_stage

    # 成長ポイント付与
    current_user.growth_logs.create(growth_point: 1)
    after_stage = current_user.current_stage

    @post.stage = after_stage

    # コメント分岐
    comment = after_stage != before_stage ? "🎉 ステージアップ！" : "🍰 今日の投稿！"

    GrowthRecord.create!(
      user: current_user,
      post: @post,
      stage: after_stage,
      cake_type_at_post: current_user.cake_type, 
      date: Date.today,
      comment: comment
    )

      redirect_to @post, notice: "投稿しました🍰"
    else
      render :new
    end
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
      @posts = @posts.where("search_categories LIKE ?", "%#{params[:exercise]}%")
    end

    if params[:cake_type].present?
      @posts = @posts.where(cake_type_at_post: params[:cake_type])
    end

    if params[:growth_status] == "finished"
      @posts = @posts.where(stage: 9)
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