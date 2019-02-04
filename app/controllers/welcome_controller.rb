class WelcomeController < ApplicationController
  def index
    if params[:tag]
      @all_tutorials = Tutorial.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
      @visitor_tutorials = Tutorial.visitor_tuts
    else
      @all_tutorials = Tutorial.all.paginate(:page => params[:page], :per_page => 5)
      @visitor_tutorials = Tutorial.visitor_tuts
    end
  end
end
