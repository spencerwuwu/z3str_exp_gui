class PagesController < ApplicationController
  class ResultData
    @tool
    @test_result

    def initialize(tool_data, result)
      @tool = tool_data
      @test_result = result
    end

    def tool
      return @tool
    end

    def test_result
      return @test_result
    end
  end

  def index
    tools = Tool.all
    @result_datas = []
    tools.each do |tool|
      test_result = TestResult.where(:tool_id => tool.id).order("created_at DESC").first
      if test_result != nil
        result = ResultData.new(tool, test_result)
        @result_datas << result
      end
    end
  end

  def show
    @results = TestResult.where(:tool_id => params[:id]).order("created_at DESC")
    @tool = Tool.where(:id => params[:id]).first
  end

  # private 
  # def tool_params
  #   params.require(:tool).permit(:name, :test_cycle)
  # end

end


