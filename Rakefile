require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rake/extensiontask"

task build: :compile

Rake::ExtensionTask.new("tesseract") do |ext|
  ext.lib_dir = "lib/tesseract"
end

task default: %i[clobber compile spec]
