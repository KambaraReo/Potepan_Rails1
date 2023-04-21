class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :start_at, :end_at, :is_all_day, :memo))
    @is_all_day_show = ""
    if @post.save
      flash[:success] = "スケジュールを新規作成しました"
      redirect_to posts_path
    else
      flash.now[:failure] = "スケジュールを作成できませんでした"
      render "new"
    end
  end

  def show
    @post = Post.find(params[:id])
    @is_all_day_show = ""
    if @post.is_all_day
      @is_all_day_show = "⚪︎"
    else
      @is_all_day_show = ""
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params.require(:post).permit(:title, :start_at, :end_at, :is_all_day, :memo))
      flash[:success] = "ID:#{@post.id}のスケジュールを更新しました"
      redirect_to posts_path
    else
      flash.now[:failure] = "スケジュールを更新できませんでした"
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "ID:#{@post.id}のスケジュールを削除しました"
    redirect_to posts_path
  end

end
