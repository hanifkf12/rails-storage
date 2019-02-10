class ArticleController < ApplicationController

  def index
    @article = Article.all
    render json: @article
  end

  def show
    @article = Article.find(params[:id])
    render json: {url: url_for(@article.poster)}
    # redirect_to url_for(@article.poster)
  end

  def create
    @article = Article.new(article_params)
    # @article.poster.attach(params[:article][:poster])
    if @article.save
      render json: @article
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if delete_poster(@article.poster.signed_id)
      if @article.destroy
        render json: {status: 'deleted'}
      end
    end
    # if @article&.destroy
    #   delete_poster(@article.poster.signed_id)
    #   render json: {status: 'deleted'}
    # end
  end

  # def delete_poster(id)
  #   @poster = ActiveStorage::Blob.find_signed(id)
  #   @poster.purge
  # end

  def article_params
    params.permit(:title, :content, :poster)
  end
end
