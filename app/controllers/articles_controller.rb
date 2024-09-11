class ArticlesController < ApplicationController
  before_action :authorize_own_article, :authenticate_user, :authorize_private_article
  skip_before_action :authorize_own_article, only: [ :show, :index, :new, :create ]
  skip_before_action :authorize_private_article, only: [ :index, :new, :create ]
  def index
    @articles = Article.all
  end

  def show
    # set the variable article to the value from database,
    # take the id of it from the parameters passed by user
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    user = User.find(session[:user_id])

    @article = user.articles.create(article_params)
    puts @article.category
    # if saved successfully then redirect to it
    if @article
      redirect_to @article
    # if not saved successfuly return status unprocessable entity
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # sets the @article instance variable to the article from the database
    # such that when edit page is accessed form fields are populated already
    @article = Article.find(params[:id])
  end

  def update
    # get the article from the database
    @article = Article.find(params[:id])

    # update with the provided user parameters
    if @article.update(article_params)
      # if success redirect to the article
      redirect_to @article
    else
      # else return 422
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # get article from database
    @article = Article.find(params[:id])

    # delete the article from database
    @article.destroy

    # return to root
    redirect_to root_path, status: :see_other
  end

  private
    # define what parameters are allowed to be passed by user
    # in the request. permit title and body from article
    def article_params
      params.require(:article).permit(:title, :body, :status, :category)
    end

    def authorize_own_article
      @article = Article.find(params[:id])
      if @article.user.id != session[:user_id]
        redirect_to root_path, status: :unauthorized
      end
    end

    def authorize_private_article
      @article = Article.find(params[:id])
      if @article.user.id != session[:user_id] and @article.private?

        redirect_to root_path, status: :unauthorized
      end
    end
end
