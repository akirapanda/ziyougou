class  Admin::RecommendEventsController < Admin::BaseController  
 
  def show
    @event = RecommendEvent.find(params[:id]) 
  end
  
  def index
    @q = RecommendEvent.search(params[:q])
    @events = @q.result(distinct: true)
    @events_grid = initialize_grid(@events,:per_page => 50)
  end
  
  def new
    @event = RecommendEvent.new
  end
  
  def create
    @event = RecommendEvent.new(recommend_event_params) 
    if @event.save
      redirect_to [:admin,@event],:notice=>"新建帮助推荐资讯信息成功!"
    else
      render 'new'
    end
  end

  def edit
    @event = RecommendEvent.find(params[:id]) 
  end

  def update
    @event = RecommendEvent.find(params[:id]) 
    if @event.update(recommend_event_params)
      redirect_to [:admin,@event],:notice=>"更新帮助推荐资讯信息成功!"
    else
      render 'edit'
    end
  end

  def destroy
    @event = RecommendEvent.find(params[:id]) 
    @event.destroy
    redirect_to admin_recommend_events_path,:notice=>"删除推荐资讯信息成功"
  end
  
  private
  def recommend_event_params
    params.require(:recommend_event).permit!
  end
end