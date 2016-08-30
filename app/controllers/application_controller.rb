class ApplicationController < ActionController::Base
  # newsfeed
  include PublicActivity::StoreController

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  after_action :set_navbar

  def after_sign_in_path_for(resource_or_scope)
    if resource.sign_in_count == 1 and current_user.freelancer
       edit_freelancer_path(current_user.freelancer)
    else
       root_path
    end
end

  def set_navbar
    @navbar ||= :left
  end

end
