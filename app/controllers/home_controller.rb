class HomeController < ApplicationController
  # Devise authentication
  before_action :authenticate_user!

  def index
  end

end
