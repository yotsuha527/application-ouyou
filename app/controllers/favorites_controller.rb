class FavoritesController < ApplicationController

  def create
    path = Rails.application.routes.recognize_path(request.referer)
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    if path[:controller] == "books" && path[:action] == "index"
      redirect_to books_path
    elsif path[:controller] == "books" && path[:action] == "show"
      redirect_to book_path(book.id)
    elsif path[:controller] == "users" && path[:action] == "show"
      redirect_to user_path(book.user_id)
    end
  end

  def destroy
    path = Rails.application.routes.recognize_path(request.referer)
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    if path[:controller] == "books" && path[:action] == "index"
      redirect_to books_path
    elsif path[:controller] == "books" && path[:action] == "show"
      redirect_to book_path(book.id)
    elsif path[:controller] == "users" && path[:action] == "show"
      redirect_to user_path(book.user_id)
    end
  end
end
