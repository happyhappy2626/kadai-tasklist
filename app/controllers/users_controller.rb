class UsersController < ApplicationController

  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザーを登録しました'
      redirect_to controller: :tasks, action: :index
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました'
      render :new
    end
  end
  
  private
  
  def user_params
    # password_confirmation はパスワードの確認用
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
