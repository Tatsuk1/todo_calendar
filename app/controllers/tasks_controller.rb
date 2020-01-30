class TasksController < ApplicationController
  before_action :login_required
  require 'pry'

  def index
    @tasks = current_user.tasks
    @hp = current_user.hp / 5
    @no_hp = 20 - @hp
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    #binding.pry
    if @task.save
      if @task.alone == true
        @task.user.hp += 10
        if @task.user.hp > 100
          @task.user.hp = 100
        end
        @task.user.save
      else
        @task.user.hp -= 10
        if @task.user.hp < 0
          @task.user.hp = 0
        end
        @task.user.save
      end
      flash[:success] = "タスク「#{@task.name}」を登録しました"
      redirect_to tasks_url
    else
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update!(task_params)
      flash[:success] = "タスク「#{@task.name}」を更新しました"
      redirect_to tasks_url
    else
      render :edit
    end
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    flash[:success] = "タスク「#{@task.name}」を削除しました"
    redirect_to tasks_url
  end

  private

    def task_params
      params.require(:task).permit(:name, :description, :alone)
    end
end
