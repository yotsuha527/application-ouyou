class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice] = "user update successfully" 
    else
      render :edit
    end
  end

  def index
    @users = User.all
    @books = Book.all
    @book = Book.new
    @user = current_user
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :email)
  end
end
