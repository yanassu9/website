class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session_params][:eamil])
    if user && user.authenticate(params[:session_params][:password])
      log_in user
      redirect_to root_path, succsess: 'ログインに成功しました'
    else
      flash.now[:danger]='ログインにしっぱいしました '
        render :new
    end
  end
  
    def destroy
      log_out
      redirect_to root_url, info: 'ログアウトしました'
    end
    
    private
    def log_in(user)
      session[:user_id] = useer.id
    end
    
    def log_out
      session.delete(:user_id)
      @current_user = nil
    end
    def session_params
    params.require(:session).permit(:email, :password)
    end
end
