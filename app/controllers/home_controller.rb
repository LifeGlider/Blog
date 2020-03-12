class HomeController < ApplicationController
  before_action :store_user_location!, if: :storable_location?

  def index
  end

  private
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
    end

    def store_user_location!
      # :user is the scope we are authenticating
      store_location_for(:user, request.fullpath)
    end
end
