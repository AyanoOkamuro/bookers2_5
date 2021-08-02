class UsersController < ApplicationController

  def index
    @users = User.all
    @book = Book.new
  end

  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    book.save
    redirect_to book_path(book.id)
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
    #if @user == current_user.id
      #render "edit"
    #else
      #redirect_to user_path(current_user.id)
    #endだとなぜかダメ
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end