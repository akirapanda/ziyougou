class  Mobile::TripGuidesController < Mobile::BaseController  
  def index
    @trip_guides = TripGuide.all
  end
  
  
  def show
    @trip_guide = TripGuide.find params[:id]
  end
  
end