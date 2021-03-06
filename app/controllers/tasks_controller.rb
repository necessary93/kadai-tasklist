class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :new, :edit, :destroy]
  before_action :correct_user, only: [:show, :destroy, :edit]
  
  def index
    if logged_in?
      @user = current_user
      @task = current_user.tasks.build  # form_for 用
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
      if @task.save
        flash[:success] = 'タスクを作成しました。'
        redirect_to root_url
      else
        @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
        flash.now[:danger] = 'タスクの作成に失敗しました。'
        render 'tasks/new'
      end
  end

  def edit
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'タスクは更新されました'
      redirect_to @task
    else
      flash.now[:danger] = '＊更新エラー＊'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end


  private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end