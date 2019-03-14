class PagesController < ApplicationController
  def index
    tools = Tool.all
    @tools_overview = []
    tools.each do |tool|
      item = TestResult.where(:tool_id => tool.id).order("created_at DESC").first
      item.name = tool.name
      @tools_overview << item
    end
  end

  def show
    @items = TestResult.where(:tool_id => params[:id]).order("created_at DESC")
    @tool_name = Tool.where(:id => @items.first.tool_id).name
  end

  private 
  def tool_params
    params.require(:tool).permit(:name, :test_cycle)
  end

end
