require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rdoc/task'

Rake::TestTask.new

Rake::RDocTask.new do |rd|
  rd.main = 'README.rdoc'

  rd.options << '--charset=utf8'

  rd.rdoc_dir = 'doc'

  rd.rdoc_files.include 'README.rdoc'
  rd.rdoc_files.include 'LICENSE'
  rd.rdoc_files.include 'lib/**/*.rb'

  rd.title = 'RUTorrent'
end
