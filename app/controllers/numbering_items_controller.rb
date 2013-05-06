class NumberingItemsController < ApplicationController
  unloadable
  before_filter :find_project
  before_filter :find_numbering_prefix, :authorize
  before_filter :find_numbering_item, :except => [:index, :new, :create, :preview]

  def index
    logger.debug("[DEBUG]NumberingItemsController#index")
    @numbering_items = NumberingItem.find(
       :all, :conditions => ["numbering_prefix_id = #{@numbering_prefix.id}"])
  end

  def new
    logger.debug("[DEBUG]NumberingItemsController#new")
    @numbering_item = NumberingItem.new()
  end

  def create
    logger.debug("[DEBUG]NumberingItemsController#create")
    numbering_item = NumberingItem.new(params[:numbering_item])
    numbering_item.numbering_prefix_id = @numbering_prefix.id
    @numbering_prefix.assigned = @numbering_prefix.assigned + 1
    numbering_item.number = @numbering_prefix.assigned

    numbering_item.save() and @numbering_prefix.save()
    flash[:notice] = l(:notice_successful_create)
    redirect_to project_numbering_item_path(:id => numbering_item,
                                :numbering_prefix_id => @numbering_prefix)
  rescue ActiveRecord::StaleObjectError
    flash.now[:error] = l(:notce_locking_conflict)
  end

  def show
    logger.debug("[DEBUG]NumberingItemsController#show")
  end

  def edit
    logger.debug("[DEBUG]NumberingItemsController#edit")
  end

  def update
    logger.debug("[DEBUG]NumberingItemsController#update")
    @numbering_item.attributes = params[:numbering_item]
    if @numbering_item.save
      flash[:notice] = l(:notice_successful_update)
      redirect_to project_numbering_item_path(@project, @numbering_item.id,
                              :numbering_prefix_id => @numbering_prefix.id)
    end
  rescue ActiveRecord::StaleObjectError
    flash.now[:error] = l(:notice_locking_conflict)
  end

  def destroy
    logger.debug("[DEBUG]NumberingItemsController#destroy")
    @numbering_item.destroy
    redirect_to project_numbering_items_path(
        :numbering_prefix_id => @numbering_prefix)
  end

private
  
  def find_project
    logger.debug("[DEBUG]NumberingItemsController#find_project")
    @project = Project.find(params[:project_id])
    logger.debug("[DEBUG]>>project=#{@project}")
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_numbering_prefix
    logger.debug("[DEBUG]NumberingItemsController#find_numbering_prefix")
    logger.debug("[DEBUG]>>numbering_prefix_id = #{@numbering_prefix_id}")
    @numbering_prefix = NumberingPrefix.find(params[:numbering_prefix_id])
    logger.debug("[DEBUG]>>numbering_prefix=#{@numbering_prefix}")
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_numbering_item
    logger.debug("[DEBUG]NumberingItemsController#find_numbering_item")
    @numbering_item = NumberingItem.find(params[:id])
    logger.debug("[DEBUG]>>numbering_item=#{@numbering_item}")
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end
