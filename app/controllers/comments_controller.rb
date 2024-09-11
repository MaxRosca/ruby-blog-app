class CommentsController < ApplicationController
  before_action :authenticate_user
  def create
    # find the article that was commented
    @article = Article.find(params[:article_id])
    # create a new comment (interesting that you can create the object
    # from the list of comments from article)
    @comment = @article.comments.create(comment_params)
    @comment.user = User.find(session[:user_id])

    @comment.save
    # redirect to the article to which the comment was added
    redirect_to article_path(@article)
  end

  def destroy
    # get the article with the id
    @article = Article.find(params[:article_id])
    # find the comment with the provided id
    @comment = @article.comments.find(params[:id])
    # delete te comment
    @comment.destroy

    # redirect to the article
    redirect_to article_path(@article), status: :see_other
  end

  def like
    @comment = Comment.find(params[:comment_id])

    user = User.find(session[:user_id])

    @like = @comment.likes.create(user_id: session[:user_id], comment_id: @comment.id)
    puts @comment.likes
    puts @like.comment
    if @like.persisted?
      head :ok
    else
      puts @like.errors.full_messages
      head :unprocessable_entity
    end
  end

  private
    def comment_params
      # allow only commenter and body when creating a comment
      params.require(:comment).permit(:body, :status)
    end
end
