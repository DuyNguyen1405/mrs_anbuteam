class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :danger, :info

  def load_data_static
    if user_signed_in?
      @followings = current_user.just_followed
        .limit Settings.load_followings
      @know_users = current_user.know_users.limit Settings.load_know_users
      @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
      @conversations = Conversation.involving(current_user).order("created_at DESC")
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update,
      keys: [:name, :role, :sex, :avatar])
  end

  def load_popular_movies
    @top_movies = Movie.top_movies.includes :genres
    @recent_movies = Movie.recent_movies.includes :genres
  end

  def load_messages
    if current_user
      @conversations = Conversation.involving(current_user).order("created_at DESC")
    end
  end
end
