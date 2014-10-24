class  Mobile::RecommendEventsController < Mobile::BaseController  
  def index
    @recommend_events = RecommendEvent.all
  end
  
  
  def show
    @recommend_event = RecommendEvent.find params[:id]
  end
  
end