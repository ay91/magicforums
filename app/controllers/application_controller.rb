class ApplicationController < ActionController::Base
  include Pundit
    protect_from_forgery with: :exception

    rescue_from Pundit::NotAuthorizedError do |exception|
      message = "You're not authorized"
      if request.format.html?
        flash[:danger] = message
        redirect_to request.referrer || root_path
      else
        flash.now[:danger] = message
        render 'layouts/flash'
      end

    end

  private

  def current_user
    return unless session[:id]
    @current_user = User.find_by(id: session[:id])
  end
  helper_method :current_user

  def authenticate!
    unless current_user
      message = "You need to login first"
      if request.format.html?
        flash[:danger] = message
        redirect_to root_path
      else
        flash.now[:danger] = message
        render "layouts/flash"
      end
    end
  end
end
