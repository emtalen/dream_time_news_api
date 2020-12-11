class Api::ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :is_user_journalist?, only: [:create]

  def create
    article = current_user.articles.create(article_params)
    if article.persisted?
      render json: { message: "Your article was successfully created!" }, status: 201
    else
      render json: { message: "Something went wrong!" }
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :sub_title, :content)
  end

  def is_user_journalist?
    unless current_user.journalist?
      render json: { message: "You are not authorized to create an article." }, status: 401
    end
  end
end
