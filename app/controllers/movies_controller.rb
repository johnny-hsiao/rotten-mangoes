class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    if params[:search_title] != "" 
      @movies = @movies.where("title LIKE ?", "%#{params[:search_title]}%")
    end
    if params[:search_dir] != ""
      @movies = @movies.where("director LIKE ?", "%#{params[:search_dir]}%")
    end
    if params[:search_duration] != ""
      case params[:search_duration]
      when "Under 90 minutes"
        @movies = @movies.where("runtime_in_minutes < 90")
      when "Between 90 and 120 minutes"
        @movies = @movies.where("runtime_in_minutes BETWEEN 90 AND 120")
      when "Over 120 minutes"
        @movies = @movies.where("runtime_in_minutes > 120")
      end
    end
    if @movies.size == 0
      flash[:notice] = "DB migrate"
      @movies = Movie.all
    else
      @movies
    end
  end

  def show
    movie_selected
  end

  def new
    @movie = Movie.new
  end

  def edit
    movie_selected
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    movie_selected

    if @movie.update_attributes(movie_params)
      redirect_to @movie
    else
      render :edit
    end
  end

  def destroy
    movie_selected
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_selected
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :remote_poster_image_url_url
    )
  end
end
