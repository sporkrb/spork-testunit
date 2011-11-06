class Spork::TestFramework::TestUnit < Spork::TestFramework
  DEFAULT_PORT = 8988
  HELPER_FILE = File.join(Dir.pwd, "test/test_helper.rb")

  def run_tests(argv, stderr, stdout)
    if defined? MiniTest
      # Ruby 1.9
      MiniTest::Unit.output = stdout

      # MiniTest's test/unit does not support -I or -r
      # Extract them and remove from arguments that are passed to testrb.
      argv.each_with_index do |arg, idx|
        if arg =~ /-I(.*)/
          if $1 == ''
            # Path is next argument.
            include_path = argv[idx + 1]
            argv[idx + 1] = nil # Will be squashed when compact called.
          else
            include_path = $1
          end
          $LOAD_PATH << include_path
          argv[idx] = nil
        elsif arg =~ /-r(.*)/
          if $1 == ''
            # File is next argument.
            require_file = argv[idx + 1]
            argv[idx + 1] = nil # Will be squashed when compact called.
          else
            require_file = $1
          end
          require require_file
          argv[idx] = nil
        end
      end
      argv.compact!

      require 'test/unit'                                                                                         
      if Test::Unit.respond_to?(:setup_argv)
        # copied from ruby-1.9.2-p136/bin/testrb:
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
        # copied from ruby-head/bin/testrb:
        tests = Test::Unit::AutoRunner.new(true)
        tests.options.banner.sub!(/\[options\]/, '\& tests...')
        unless tests.process_args(argv)
          abort tests.options.banner
        end
        files = tests.to_run
        $0 = files.size == 1 ? File.basename(files[0]) : files.to_s
        tests.run
      end
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
