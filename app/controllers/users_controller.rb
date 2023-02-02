class UsersController < ApplicationController
 before_action :correct_user, only: [:edit, :update ]


   def show
    @user = User.find(params[:id])
    @book = Book.new
    @userbook = @user.books
   end

# 以下を追加
  def create
    users = User.new(user_params)
    users.save
    redirect_to '/top'
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])

  end

def update
    @user = User.find(params[:id])
   if @user.update(user_params)
     flash[:notice] = "You have updated user successfully"
     redirect_to user_path(current_user.id)
   else
     render:edit
   end
end


   private
  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end
   def correct_user
     @user = User.find(params[:id])
     unless @user == current_user
     redirect_to user_path(current_user)
 end
   end
end
