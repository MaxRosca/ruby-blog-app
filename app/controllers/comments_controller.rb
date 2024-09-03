class CommentsController < ApplicationController
  def create 
    # find the article that was commented
    @article = Article.find(params[:article_id])
    
    # create a new comment (interesting that you can create the object 
    # from the list of comments from article)
    @comment = @article.comments.create(comment_params)

    # redirect to the article to which the comment was added
    redirect_to article_path(@article)
  end

  private 
    def comment_params
      # allow only commenter and body when creating a comment
      params.require(:comment).permit(:commenter, :body)
    end
end
