class Spork::TestFramework::TestUnit < Spork::TestFramework
  DEFAULT_PORT = 8988
  HELPER_FILE = File.join(Dir.pwd, "test/test_helper.rb")

  def run_tests(argv, stderr, stdout)
    if defined? MiniTest
      # Ruby 1.9
      MiniTest::Unit.output = stdout

      # MiniTest's test/unit does not support -I
      argv.reject!{|item|
        if item =~ /-I(.*)/
          $LOAD_PATH << $1
          true
        end
      }

      # copied from ruby-1.9.2-p136/bin/testrb:
      require 'test/unit'
      Test::Unit.setup_argv(argv) {|files|
        if files.empty?
          puts "Usage: testrb [options] tests..."
          exit 1
        end
        if files.size == 1
          $0 = File.basename(files[0])
        else
          $0 = files.to_s
        end
        files
      }

      MiniTest::Unit.new.run(argv)
    else
      # Ruby 1.8
      Object.send(:remove_const, :STDOUT); Object.send(:const_set, :STDOUT, stdout)
      require 'test/unit/autorunner'
      r = Test::Unit::AutoRunner.new(true)
      exit(false) unless r.process_args(argv)
      r.run
    end
  rescue => e
    puts "-"*30
    puts "Error executing #{argv.join(' ')}"
    puts e.message
    puts e.backtrace
    puts "-"*30
  end
end
