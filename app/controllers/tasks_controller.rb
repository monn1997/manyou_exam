class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]  

  def index
    @tasks = Task.all.order(created_at: :desc).page(params[:page])
    #@tasks = Task.all.order(created_at: :desc)
    #@tasks = @taskspage(params[:page]).per(10)

    if params[:sort_expired]
      @tasks = Task.order(deadline: :desc)
    end
    
    if params[:task] && params[:task][:status].present?
      @tasks = @tasks.status_search(params[:task][:status])
    end
    
    if params[:task] && params[:task][:title].present?
      @tasks = @tasks.title_search(params[:task][:title])
    end    
    

    if params[:sort_priority]
      @tasks = Task.order(priority: :desc) 
    end  
    
    @tasks = @tasks.page(params[:page]).per(5)


  end  

  def new
    @task =Task.new
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
    else     
      if @task.save
        redirect_to tasks_path, notice: "投稿しました！"
      else
        render :new
      end  
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

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end  

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority)
  end  

  def set_task
    @task = Task.find(params[:id])
  end  
end
