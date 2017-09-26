class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = 'タスクが登録されました'
      redirect_to @task
    else
      flash.now[:danger] = '＊登録エラー＊'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
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
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'タスクは削除されました'
    redirect_to tasks_url
  end
end

  private

  # Strong Parameter
  def task_params
    params.require(:message).permit(:content)
  end