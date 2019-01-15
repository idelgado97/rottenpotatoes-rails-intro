class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
  
 
		# this will show all the available movies
	@all_ratings = Movie.select(:rating).map(&:rating).uniq
	
	# now, need to get which ones they checked
	@selected_ratings = @all_ratings
	@movies = Movie.where({rating: @selected_ratings})
	
	if params[:ratings]
		@selected_ratings= params[:ratings].keys
		@movies = Movie.where({rating: @selected_ratings})
	end
	

	
	if params[:order] == "title"
		@movies = Movie.where({rating: @selected_ratings}).order(:title)
		@title_movie = "hilite"
		@title_release = ""
		
		
	elsif params[:order] == "release_date"
		@movies = Movie.where({rating: @selected_ratings}).order(:release_date)
		@title_release = "hilite"
		@title_movie = ""
	end
	
	
	#if params[:order] != session[:order] or params[:ratings] != session[:ratings]
     # session[:order] = params[:order]
     # session[:ratings] = @selected_ratings
     # redirect_to movies_path  
    #end
	
	
	
	
	
	
	
	
	
	
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

end
