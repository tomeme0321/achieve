class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit, :update, :destroy]
  before_action :authenticate_user! #trueならそれぞれのアクション、falseならログイン画面表示
  
  def index
    @blogs =Blog.all
    #binding.pry
  end
  
  def new
    if params[:back]
    @blog = Blog.new(blogs_params)   
   else
    @blog = Blog.new
   end
 end
  
  def create
    @blog = Blog.new(blogs_params) 
    @blog.user_id = current_user.id
    if @blog.save
     redirect_to blogs_path, notice: "ブログを作成しました！"
    else
    render 'new'
   end
  end
  
  def edit
  end
  
  def update
   if @blog.update(blogs_params)
      redirect_to blogs_path, notice: "ブログを更新しました！"
    else
      render 'edit'
    end
  end
  
  def destroy
   #binding.pry
    @blog.destroy
    redirect_to blogs_path, notice: "削除しました"
  end
  
  def confirm
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid?
  end
  #valid?/invalid?メソッドはバリデーションを実行し、失敗したらfalse/trueを返す
  
  private
  def blogs_params
    params.require(:blog).permit(:title, :content)
  end
  
  def set_blog
    @blog = Blog.find(params[:id])
  end
end

