# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

begin
  require 'bones'
  Bones.setup
rescue LoadError
  begin
    load 'tasks/setup.rb'
  rescue LoadError
    raise RuntimeError, '### please install the "bones" gem ###'
  end
end

ensure_in_path 'lib'

require 'germinate'
require 'germinate/publisher'
require 'germinate-gist'

require 'germinate-atompub'

task :default => 'spec:run'

PROJ.name = 'germinate-atompub'
PROJ.authors = 'Avdi Grimm'
PROJ.email = 'avdi@avdi.org'
PROJ.url = 'http://github.com/devver/germinate-wordpress'
PROJ.version = GerminateAtompub::VERSION
PROJ.rubyforge.name = 'germinate-app'
PROJ.ignore_file = '.gitignore'

depend_on 'ick',        '~> 0.3.0'
depend_on 'atom-tools', '~> 2.0.3'
depend_on 'highline',   '~> 1.5.0'
depend_on 'fattr',      '~> 1.0.3'

PROJ.spec.opts << '--color'

# EOF
