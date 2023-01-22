class UsersController < ApplicationController


   def show
    @user = User.find(params[:id])
    @book = Book.new

   end

# 以下を追加
  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    users = User.new(user_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    users.save
    # 4. トップ画面へリダイレクト
    flash[:notice] = "投稿が成功しました"
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
    @user.update(user_params)
    redirect_to user_path(@user.id)
end


   private
  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:title, :body,:profile_image, :name)
  end
end