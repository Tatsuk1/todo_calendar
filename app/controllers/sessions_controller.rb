class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: session_params[:name])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      flash[:success] = "ログインしました"
      redirect_to root_path
    else
      render:new
    end
  end

  def destroy
    reset_session
    flash[:success] = "ログアウトしました"
    redirect_to root_path
  end

  private 

    def session_params
      params.require(:session).permit(:name,:password)
    end
end
