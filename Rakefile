require 'rake'
require 'rake/rdoctask'

desc 'Generate RDoc documentation for acts_as_messageable.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  files = ['README', '**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = "README" # page to start on
  rdoc.title = "acts_as_messageable"
  rdoc.rdoc_dir = 'doc' # rdoc output folder
end
