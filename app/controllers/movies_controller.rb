class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
def index
    @movies = params[:ratings]&.any? ? Movie.find_all_by_ratings(params[:ratings].keys) : Movie.all
    @all_ratings=Movie.ratings # all unique ratings from the Movie class in movie.rb
    
    if params[:sort]
      @movies = @movies.order(params[:sort])
    end
    
    session[:sort] = params[:sort] if params[:sort]
    session[:ratings] = params[:ratings] if params[:ratings] || params[:commit] == 'Refresh'

    if ((!params[:sort] && !params[:ratings]) && (session[:sort] && session[:ratings])) || (!params[:sort] && session[:sort])
      flash.keep
      redirect_to movies_path(sort: session[:sort], ratings: session[:ratings])
    elsif !params[:ratings] && session[:ratings]
      flash.keep
      redirect_to movies_path(sort: params[:sort], ratings: session[:ratings])
    end
    
    
end
  
  
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
