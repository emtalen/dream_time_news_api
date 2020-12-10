class Api::ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :is_user_journalist?, only: [:create]

  def create
    article = Article.create(article_params)
    if article.persisted?
      render json: { message: "Your article was successfully created!" }, status: 201
    else
      render json: { message: "Something went wrong!" }
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :sub_title, :content, :author)
  end

  def is_user_journalist?
    current_user.journalist?
  end
end
