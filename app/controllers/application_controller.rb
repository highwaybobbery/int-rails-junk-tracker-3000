class ApplicationController < ActionController::Base
  # We wouldn't do this in production, but feel free to leave this in for this exercise.
  skip_before_action :verify_authenticity_token
end
