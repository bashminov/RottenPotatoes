class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.ratings
#  @all_ratings = ["G", "PG", "PG-13", "R"]
    ratings = @all_ratings
    if params[:ratings]
       ratings = params[:ratings].keys
       @checkboxes = params[:ratings]
       session[:ratings] = params[:ratings]
    elsif session[:ratings] && params[:ratings] == nil
       params[:ratings] = session[:ratings]
       flash.keep
       redirect_to movies_path params
    else
       @checkboxes = @all_ratings
    end
    if params[:order] == "title"
      @movies = Movie.find(:all, :conditions => {:rating => ratings}, :order => "lower(title) ASC")
      @hilite = "title"
    else
      if params[:order] == "release_date"
        @hilite = "date"
      end
      @movies = Movie.find(:all, :order => params[:order], :conditions => {:rating => ratings})
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
