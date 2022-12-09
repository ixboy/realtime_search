class SearchesController < ApplicationController
  def index
    @searches = Search.order_by_most_searched.first(15)
  end
end
