require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc "Benchmark some methods against plain Enumerable"
task :benchmark  do
  load File.expand_path("./benchmark/benchmark_self_enumerable.rb")
end
