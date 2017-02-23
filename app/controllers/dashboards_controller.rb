class DashboardsController < ApplicationController
  def index
    @atheletes = User.paginate(:page => params[:page])
  end
  def search
    @search_term =  params[:search_name]
    @atheletes = User.search_by_name(@search_term)
      .paginate(:page => params[:page])
  end
end
