class RatingsController < ApplicationController
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    @rating = @article.ratings.create(rating_params)
    @rating.user = current_user
    if @rating.save
      redirect_to article_path(@article)
    else
      render 'articles/show'
    end
  end

  def edit
    @article = Article.find(params[:article_id])
    @rating = @article.ratings.where("user_id == ?", current_user.id).take
    if @rating.update(rating_params)
      redirect_to article_path(@article)
    else
      render 'articles/show'
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @rating = @article.ratings.where("user_id == ?", current_user.id).take
    if @rating.destroy
      redirect_to article_path(@article)
    else
      render 'articles/show'
    end
  end

  private
  def rating_params
    params.require(:rating).permit(:rating_value)
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end
end
