class PagesController < ApplicationController

  # Group result with its tool
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

  # Group tools with the same benchmark
  class BenchmarkResult
    @result_datas
    @name
    def initialize(bname, datas)
      @name = bname
      @result_datas = datas
    end

    def name
      return @name
    end
    
    def result_datas
      return @result_datas
    end
  end

  # Controller for index.html.slim
  def index
    tools = Tool.all
    benchmarks = BenchmarkName.all

    @benchmark_results = []

    benchmarks.each do |benchmark|
      result_datas = []
      tools.each do |tool|
        test_result = TestResult.where(:tool_id => tool.id, :benchmark => benchmark.name).order("created_at DESC").first
        if test_result != nil
          result = ResultData.new(tool, test_result)
          result_datas << result
        end
      end
      benchmark_result = BenchmarkResult.new(benchmark.name, result_datas)
      @benchmark_results << benchmark_result
    end

    @benchmark_types = BenchmarkType.all
  end

  # Controller for show.html.slim
  def show
    benchmarks = BenchmarkName.all
    @tool = Tool.where(:id => params[:id]).first

    @benchmark_results = []

    benchmarks.each do |benchmark|
      results = TestResult.where(:tool_id => params[:id], :benchmark => benchmark.name).order("created_at DESC")
      if results != nil
        benchmark_result = BenchmarkResult.new(benchmark.name, results)
        @benchmark_results << benchmark_result
      end
    end
  
    @benchmark_types = BenchmarkType.all
  end

  # Render pages search by benchmark_type
  def show_type
    tools = Tool.all
    benchmarks = BenchmarkName.where(:benchmark_type_id => params[:id])

    @benchmark_results = []

    benchmarks.each do |benchmark|
      result_datas = []
      tools.each do |tool|
        test_result = TestResult.where(:tool_id => tool.id, :benchmark => benchmark.name).order("created_at DESC").first
        if test_result != nil
          result = ResultData.new(tool, test_result)
          result_datas << result
        end
      end
      benchmark_result = BenchmarkResult.new(benchmark.name, result_datas)
      @benchmark_results << benchmark_result
    end
  
    @benchmark_types = BenchmarkType.all
  end

end


