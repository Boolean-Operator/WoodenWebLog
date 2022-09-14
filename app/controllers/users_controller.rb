class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 4)
  end
  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit 
  end
  
  def update 
    if @user.update(user_params)
      flash[:notice] = "Your information has been updated successfully"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome the Wooden Web Log #{@user.username}, you have successfully joined."
      redirect_to articles_path
    else
      render 'new'
    end
  end


  private 
  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = "You may only update your own profile"
      redirect_to @user
    end
  end

  def user_params
    params.required(:user).permit(:username, :email, :password)
  end
end