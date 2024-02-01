class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    @movies = Movie.where("title LIKE ?", wildcard_search)
  end
end
