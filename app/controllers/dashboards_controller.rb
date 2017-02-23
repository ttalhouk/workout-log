class DashboardsController < ApplicationController
  def index
    @atheletes = User.paginate(:page => params[:page])
  end
end
