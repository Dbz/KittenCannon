class ApplicationController < ActionController::Api
  protect_from_forgery with: :exception
end
