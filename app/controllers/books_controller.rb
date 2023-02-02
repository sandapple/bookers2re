class BooksController < ApplicationController
 before_action :correct_user, only: [:edit, :update, :destroy]

  def new
   @books_image = BookImage.new
  end

  # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
     if @book.save
       redirect_to book_path(@book)
     else
       @books = Book.all
       render :index

     end
  end

  def index
    @books = Book.all
    @book = Book.new
    @bookuser = current_user
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new

  end

  def edit
    # @book = Book.find(params[:id])
    # if @book.user_id != current_user.id
    #   redirect_to book_path
    # end
  end

  def update
    @book = Book.find(params[:id])
   if @book.update(book_params)
      flash[:notice] = "You have updated book successfully"
    redirect_to book_path(@book.id)
   else
    render:edit
   end
  end

  def destroy
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    @book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト
  end

  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

   def correct_user
    @book = Book.find(params[:id])
     unless @book.user == current_user
    redirect_to books_path
     end
   end
end
