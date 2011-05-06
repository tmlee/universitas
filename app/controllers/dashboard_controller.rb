class DashboardController < ApplicationController
	respond_to :html, :js 
  before_filter :authenticate_user!
  def show
		last = params[:last].blank? ? Time.now + 1.second : Time.parse(params[:last])
    @feed = current_user.feed(last)
  end
  
  def update_status
    current_user.update_status(params[:status])
    redirect_to root_path
  end
end
