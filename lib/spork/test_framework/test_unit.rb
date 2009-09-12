class Spork::TestFramework::TestUnit < Spork::TestFramework
  DEFAULT_PORT = 8988
  HELPER_FILE = File.join(Dir.pwd, "test/test_helper.rb")

  def run_tests(argv, stderr, stdout)
    Object.send(:remove_const, :STDOUT); Object.send(:const_set, :STDOUT, stdout)
    require 'test/unit/autorunner'
    r = Test::Unit::AutoRunner.new(true)
    exit(false) unless r.process_args(argv)
    r.run
  rescue
    puts 'error'
  end
end
