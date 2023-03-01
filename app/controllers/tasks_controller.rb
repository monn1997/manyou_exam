class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]  

  def index
    @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(5)
    #@tasks = Task.all.order(created_at: :desc).page(params[:page])

    if params[:sort_expired]
      @tasks = Task.order(deadline: :desc)
    end
    
    if params[:task] && params[:task][:status].present?
      @tasks = @tasks.status_search(params[:task][:status])
    end
    
    if params[:task] && params[:task][:title].present?
      @tasks = @tasks.title_search(params[:task][:title])
    end    

    if params[:task] && params[:task][:label_ids].present?
      @tasks = @tasks.label_search(params[:task][:label_ids])
    end

    if params[:sort_priority]
      @tasks = Task.order(priority: :desc) 
    end  
    
    @tasks = @tasks.page(params[:page]).per(5)
    @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_ids] }) if params[:label_ids].present?

  end  

  def new
    @task =Task.new
  end

  def create
    #@task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
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
    if @task.update(task_params)
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
    @task = current_user.tasks.build(task_params)
    @labels = Label.all
    render :new if @task.invalid?
  end  

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority, :user_id, { label_ids: [] })
  end  

  def set_task
    @task = Task.find(params[:id])
  end  
end
