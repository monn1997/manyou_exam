class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]  

  def index
    @tasks = Task.all
  end  

  def new
    @task =Task.new
  end

  def create
    @task = Task.new(task_params)
    #Task.create(params.require(:task).permit(:title, :content))
    if @task.save
      redirect_to new_task_path, notice: "投稿しました！"
    else
      render :new
    end  
  end

  def show
    @task = Task.find(params[:id])
  end  

  def edit 
    @task = Task.find(params[:id])
  end

  def update 
    @task = Task.find(params[:id])
    if @task = Task.find(params[:id])
      redirect_to tasks_path, notice: "編集しました！"
    else
      render :edit
    end    
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"投稿を削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content)
  end  

  def set_task
    @task = Task.find(params[:id])
  end  
end
