class DashboardsController < ApplicationController
  def index
    @atheletes = User.all
  end
end
