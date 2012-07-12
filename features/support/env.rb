require 'aruba/cucumber'
require 'methadone/cucumber'

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
LIB_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'..','..','lib')

Before do
  # Using "announce" causes massive warnings on 1.9.2
  @puts = true
  @original_rubylib = ENV['RUBYLIB']
  ENV['RUBYLIB'] = LIB_DIR + File::PATH_SEPARATOR + ENV['RUBYLIB'].to_s
end

After do
  ENV['RUBYLIB'] = @original_rubylib
end

Before('@simulate-capture') do
  @original_fakecapture = ENV['LOLCOMMITS_FAKECAPTURE']
  ENV['LOLCOMMITS_FAKECAPTURE'] = "1"

  @original_loldir = ENV['LOLCOMMITS_DIR']
  ENV['LOLCOMMITS_DIR'] = File.join(current_dir, ".lolcommits")
end

After('@simulate-capture') do
  ENV['LOLCOMMITS_FAKECAPTURE'] = @original_fakecapture
  ENV['LOLCOMMITS_DIR'] = @original_loldir
end