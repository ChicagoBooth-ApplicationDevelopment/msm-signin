class BookmarksController < ApplicationController
  def index
    matching_bookmarks = Bookmark.all

    @list_of_bookmarks = matching_bookmarks.order({ :created_at => :desc })

    render({ :template => "bookmarks/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_bookmarks = Bookmark.where({ :id => the_id })

    @the_bookmark = matching_bookmarks.at(0)

    render({ :template => "bookmarks/show.html.erb" })
  end

  def create
    # the_id = params.fetch("path_id")
    # matching_movies = Movie.where({ :id => the_id })
    # the_movie = matching_movies.at(0)
    # the_bookmark.movie_id = @the_movie.id

    the_bookmark = Bookmark.new
    # the_bookmark.user_id = params.fetch("query_user_id")
    the_bookmark.movie_id = params.fetch("query_movie_id")

    # the_bookmark.movie_id = params.fetch("path_id")
    the_bookmark.user_id = session[:user_id]
    # the_bookmark.movie_id = @the_id
    
    # @movie_id = params.fetch("path_id")
    # @the_bookmark_name = Movie.where({:id => @movie_id}).at(0).title

    if the_bookmark.valid?
      the_bookmark.save
      redirect_to("/bookmarks", { :notice => "Bookmark created successfully." })
    else
      redirect_to("/bookmarks", { :notice => "Bookmark failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_bookmark = Bookmark.where({ :id => the_id }).at(0)

    the_bookmark.user_id = params.fetch("query_user_id")
    the_bookmark.movie_id = params.fetch("query_movie_id")

    if the_bookmark.valid?
      the_bookmark.save
      redirect_to("/bookmarks/#{the_bookmark.id}", { :notice => "Bookmark updated successfully."} )
    else
      redirect_to("/bookmarks/#{the_bookmark.id}", { :alert => "Bookmark failed to update successfully." })
    end
  end

  def destroy
    @the_id = params.fetch("path_id")
    the_bookmark = Bookmark.where({ :movie_id => @the_id }).at(0)

    the_bookmark.destroy

    redirect_to("/bookmarks", { :notice => "Bookmark deleted successfully."} )
  end
end
