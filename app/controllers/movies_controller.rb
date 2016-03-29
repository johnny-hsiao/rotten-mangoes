class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find_by(id: params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find_by(id: params[:id])
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
    @movie = Movie.find_by(id: params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to @movie
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find_by(id: params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :remote_poster_image_url_url
    )
  end
end
