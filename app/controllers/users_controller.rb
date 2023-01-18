class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash.notice = "Your account has been updated"
      redirect_to @user
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[
        :notice
      ] = "Welcome to the Alpha Blog, #{@user.username}! You have successfully signed up."
      redirect_to articles_path
    else
      render "new", status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
