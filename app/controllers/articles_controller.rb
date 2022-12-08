class ArticlesController < ApplicationController
  before_action :set_searcher_id, only: [:index]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @articles = if params[:query].present?
                  Article.where('title LIKE ?', "%#{params[:query]}%")
                else
                  Article.all.first(12)
                end
    filter_search(params[:query], session.id) if @articles
    if turbo_frame_request?
      render partial: 'articles', locals: { articles: @articles }
    else
      render :index
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def filter_search(query, session)
    return if query.nil? || query.length < 3

    current_search = Search.where(searcher_id: session.to_s).last
    if current_search.nil? || !current_search.searched?(query)
      Search.create(query: query, searcher_id: session.to_s)
    elsif current_search.query.length < query.length
      current_search.update(query: query)
    end
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def set_searcher_id
    session[:user_id] = SecureRandom.urlsafe_base64(16) if session[:user_id].nil?
  end
end
