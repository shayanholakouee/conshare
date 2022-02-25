class ArticlesController < ApplicationController
  before_action :set_article , only: [:edit, :update, :show, :destroy]
  before_action :require_user , except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "New Article Created"
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def show

  end

  def index
    @article = Article.all
  end

  def edit

  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was Updated"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    flash[:warning] = "article deleted"
    redirect_to articles_path
  end

  private
    def set_article
     @article = Article.find_by(id: params[:id])
     unless @article
       flash[:danger] = "no such article"
       redirect_to root_path
     end
    end
    def article_params
      params.require(:article).permit(:title, :description)
    end
    def require_same_user
      unless current_user == @article.user or current_user.admin?
        flash[:danger] = "Your are not the owner of this article"
        redirect_to root_path
      end
    end
end
