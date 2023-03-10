class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]    
  def index
  end      

  def new
    # ログイン中ならどっかの画面に飛ばす
    if current_user
      redirect_to tasks_path
    end  
    
    @user = User.new 
  end  

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id  
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:notice] = "権限がありません"
      redirect_to  tasks_path
    end
  end  

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "情報を編集しました！"
      redirect_to user_path
    else
      render :edit  
    end
  end  

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
