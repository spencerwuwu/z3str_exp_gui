DatabaseCleaner.clean_with(:truncation, :only => %w[display_types tools])

displays = [
  { name: 'sat'},
  { name: 'unsat'},
  { name: 'todo'},
  { name: 'others'},
  { name: 'legacy'}
]

DisplayType.create(displays)

puts "DT"

Tool.create([
  { name: "trauc",
    branch_name: "master" 
  },
  { name: "z3",
    branch_name: "master" 
  }
])

puts "Tool"

BenchmarkType.create([
  { name: "sat", display_type_id: 1},
  { name: "unsat", display_type_id: 2}
])

puts "BS"

benchmarks = [
  { name: "PyEx_sat.3.0", benchmark_type_id: 1, benchmark_splited_id: 1},
  { name: "PyEx_sat.3.1", benchmark_type_id: 1, benchmark_splited_id: 1},
  { name: "PyEx_sat.3.2", benchmark_type_id: 1, benchmark_splited_id: 1},
  { name: "Kaluza_unsat", benchmark_type_id: 2}
]
BenchmarkName.create(benchmarks)
puts "BN"

BenchmarkSplited.create(
  [{ name: "PyEx_sat.3", display_type_id: 1 }]
)

BenchmarkName.all.each do |b|
  date = 20190601
  sat = 10
  unsat = 0
  unknown = 2
  timeout = 30
  exception = 2
  misc = 0
  commit = "e207fac01"

  puts "BNe"
  Tool.all.each do |tool|
    puts "TOe"
    (0..2).step(1) do |n|
      TestResult.create([
        { date: (date + n).to_s,
          sat: sat,
          unsat: unsat,
          timeout: timeout,
          misc: misc,
          commit: commit,
          tool_id: tool.id,
          benchmark: b.name,
          unknown: unknown,
          exception: exception
        }
      ])
    end
  end

end

