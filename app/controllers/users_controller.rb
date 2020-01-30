class UsersController < ApplicationController
  before_action :login_required, except:[:new, :create]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー「#{@user.name}」を作成しました"
      redirect_to users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "ユーザー「#{@user.name}」を更新しました"
      redirect_to users_path
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "ユーザー「#{@user.name}」を削除しました"
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :admin, :password, :password_confirmation)
    end

    def require_admin
      redirect_to root_path unless current_user.admin?
    end

    def logged_in?
      !current_user.nil?
    end
end
