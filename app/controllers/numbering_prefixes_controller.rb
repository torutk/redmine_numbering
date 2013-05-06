# -*- coding: utf-8 -*-
class NumberingPrefixesController < ApplicationController
  unloadable
  menu_item :numbering
  before_filter :find_project, :authorize
  before_filter :find_numbering_prefix, :except => [:index, :new, :create]

  def index
    @numbering_prefixes = NumberingPrefix.find(
        :all, :conditions => ["project_id = #{@project.id}"])
  end

  def new
    @numbering_prefix = NumberingPrefix.new()
  end

  def create
    @numbering_prefix = NumberingPrefix.new(params[:numbering_prefix])
    @numbering_prefix.project_id = @project.id
    @numbering_prefix.assigned = 0
    if @numbering_prefix.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to project_numbering_prefixes_path(@project)
    end
  end

  def update
    @numbering_prefix.attributes = params[:numbering_prefix]
    if @numbering_prefix.save
      flash[:notice] = l(:notice_successful_update)
      redirect_to project_numbering_prefixes_path(@project)
    end
  end

  def edit
    logger.debug("[DEBUG]NumberingPrefixesController#edit")
  end

  def destroy
    @numbering_prefix.destroy
    redirect_to project_numbering_prefixes_path(@project)
  end

private

  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_numbering_prefix
    @numbering_prefix = NumberingPrefix.find_by_id(params[:id])
    render_404 unless @numbering_prefix
  end

end
