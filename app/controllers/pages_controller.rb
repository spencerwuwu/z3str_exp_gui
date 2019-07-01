class PagesController < ApplicationController

  # Group result with its tool
  class ResultData
    @tool
    @test_result
    @is_splited
    @children
    @group_id

    def initialize(tool_data, result, is_splited)
      @tool = tool_data
      @test_result = result
      @is_splited = is_splited
    end

    def set_children(children)
      @children = children
    end

    def set_id(id)
      @group_id = id
    end

    def tool
      return @tool
    end

    def is_splited
      return @is_splited
    end

    def test_result
      return @test_result
    end

    def children
      return @children
    end

    def group_id
      return @group_id
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

    benchmarks.where(:benchmark_splited_id => nil).each do |benchmark|
      result_datas = []
      tools.each do |tool|
        test_result = TestResult.where(:tool_id => tool.id, :benchmark => benchmark.name).order("created_at DESC").first
        if test_result != nil
          result = ResultData.new(tool, test_result, false)
          result_datas << result
        end
      end
      benchmark_result = BenchmarkResult.new(benchmark.name, result_datas)
      @benchmark_results << benchmark_result
    end

    bs_cnt = 0

    BenchmarkSplited.all.each do |bs|
      total_datas = []

      tools.each do |tool|
        result_datas = []
        summary = TestResult.new({date: "", sat: 0, unsat: 0, timeout: 0, misc: 0, tool_id: tool.id, benchmark: bs.name, name: tool.name, unknown: 0, exception: 0})
        c_date = 0

        benchmarks.where(:benchmark_splited_id => bs.id).each do |benchmark|
          test_result = TestResult.where(:tool_id => tool.id, :benchmark => benchmark.name).order("created_at DESC").first
          if test_result != nil
            result = ResultData.new(tool, test_result, false)
            result_datas << result
            summary.sat += test_result.sat
            summary.unsat += test_result.unsat
            summary.timeout += test_result.timeout
            summary.misc += test_result.misc
            summary.unknown += test_result.unknown
            summary.exception += test_result.exception
            n_date = test_result.date.to_i
            if n_date > c_date
              c_date = n_date
            end
          end
          if c_date != 0
            summary.date = c_date.to_s
          end
          # End for benchmarks.where...
        end

        if result_datas.length != 0
          total = ResultData.new(tool, summary, true)
          total.set_children(result_datas)
          total.set_id(bs_cnt)
          bs_cnt += 1
          total_datas << total
        end

        # End for tools.each
      end
      benchmark_result = BenchmarkResult.new(bs.name, total_datas)
      @benchmark_results << benchmark_result
      # End for BenchmarkSplited
    end

    @display_types = DisplayType.all
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
  
    @display_types = DisplayType.all
  end

  def log
    id = params[:id]
    result = TestResult.where(:id => params[:id]).first
    tool_name = Tool.where(:id => result.tool_id).first.name
    dir = "/home/deploy/ci_logs_full/"
    target_dir = "#{dir}#{tool_name}-#{result.date}-#{result.benchmark}/"
    target = "#{target_dir}#{result.benchmark}.#{result.date}.#{tool_name}.log"
    @content = File.read(target)

    @display_types = DisplayType.all
  end

  def logerr
    id = params[:id]
    result = TestResult.where(:id => params[:id]).first
    tool_name = Tool.where(:id => result.tool_id).first.name
    dir = "/home/deploy/ci_logs_full/"
    target_dir = "#{dir}#{tool_name}-#{result.date}-#{result.benchmark}/"
    target = "#{target_dir}#{result.benchmark}.#{result.date}.#{tool_name}.log.err"
    @content = File.read(target)

    @display_types = DisplayType.all
  end

  # Render pages search by benchmark_type
  def show_type
    tools = Tool.all
    display_type = params[:id].to_i
    benchmarks = []
    all_benches = BenchmarkName.all
    all_types  = BenchmarkType.all()

    all_benches.each do |benchmark|
      type_id = all_types.find(benchmark.benchmark_type_id).display_type_id
      if display_type == type_id
        benchmarks << benchmark
      end
    end

    @benchmark_results = []

    benchmarks.each do |benchmark|
      if benchmark.benchmark_splited_id != nil
        next
      end
      result_datas = []
      tools.each do |tool|
        test_result = TestResult.where(:tool_id => tool.id, :benchmark => benchmark.name).order("created_at DESC").first
        if test_result != nil
          result = ResultData.new(tool, test_result, false)
          result_datas << result
        end
      end
      benchmark_result = BenchmarkResult.new(benchmark.name, result_datas)
      @benchmark_results << benchmark_result
    end

    bs_cnt = 0
    BenchmarkSplited.where(:display_type_id => params[:id]).each do |bs|
      total_datas = []

      tools.each do |tool|
        result_datas = []
        summary = TestResult.new({date: "", sat: 0, unsat: 0, timeout: 0, misc: 0, tool_id: tool.id, benchmark: bs.name, name: tool.name, unknown: 0, exception: 0})
        c_date = 0

        benchmarks.each do |benchmark|
          if benchmark.benchmark_splited_id != bs.id
            next
          end
          test_result = TestResult.where(:tool_id => tool.id, :benchmark => benchmark.name).order("created_at DESC").first
          if test_result != nil
            result = ResultData.new(tool, test_result, false)
            result_datas << result
            summary.sat += test_result.sat
            summary.unsat += test_result.unsat
            summary.timeout += test_result.timeout
            summary.misc += test_result.misc
            summary.unknown += test_result.unknown
            summary.exception += test_result.exception
            n_date = test_result.date.to_i
            if n_date > c_date
              c_date = n_date
            end
          end
          if c_date != 0
            summary.date = c_date.to_s
          end
          # End for benchmarks.where...
        end

        if result_datas.length != 0
          total = ResultData.new(tool, summary, true)
          total.set_children(result_datas)
          total.set_id(bs_cnt)
          bs_cnt += 1
          total_datas << total
        end

        # End for tools.each
      end
      benchmark_result = BenchmarkResult.new(bs.name, total_datas)
      @benchmark_results << benchmark_result
      # End for BenchmarkSplited
    end
  
    @display_types = DisplayType.all
  end


  # Compare two log file with the same benchmark
  def show_diff
    dir = "/home/deploy/ci_logs_full/"

    result = TestResult.where(:id => params[:id1]).first
    tool_name = Tool.where(:id => result.tool_id).first.name
    target_dir = "#{dir}#{tool_name}-#{result.date}-#{result.benchmark}/"
    target = "#{target_dir}#{result.benchmark}.#{result.date}.#{tool_name}.log"

    target1 = File.read(target).split("\n")
    @tname_1 = "#{tool_name}.#{result.benchmark}.#{result.date}"

    result = TestResult.where(:id => params[:id2]).first
    tool_name = Tool.where(:id => result.tool_id).first.name
    target_dir = "#{dir}#{tool_name}-#{result.date}-#{result.benchmark}/"
    target = "#{target_dir}#{result.benchmark}.#{result.date}.#{tool_name}.log"

    target2 = File.read(target).split("\n")
    @tname_2 = "#{tool_name}.#{result.benchmark}.#{result.date}"


    if target1.length != target2.length
      @error = true
    else
      @error = false
    end

    @list = []
    @rlist1 = []
    @rlist2 = []

    target1.each_with_index do |value, index|
      if index <= 3
        next
      end
      result1_s = target1[index].split(", ")
      result2_s = target2[index].split(", ")

      if result1_s[2] != result2_s[2]
        if result1_s[2].include? "sat" and result2_s[2].include? "sat" 
          @list.append(result1_s[0])
          @rlist1.append(result1_s[2])
          @rlist2.append(result2_s[2])
        end
      end
    end

    @display_types = DisplayType.all
  end

end


