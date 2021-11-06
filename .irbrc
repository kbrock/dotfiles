# The irbrc file for Sebastian Delmont <sd@notso.net>
#
# Most of the code here came from http://wiki.rubygarden.org/Ruby/page/show/Irb/TipsAndTricks
#
unless self.class.const_defined? "IRB_RC_HAS_LOADED"
  begin # ANSI codes
    ANSI_BLACK    = "\033[0;30m"
    ANSI_GRAY     = "\033[1;30m"
    ANSI_LGRAY    = "\033[0;37m"
    ANSI_WHITE    =  "\033[1;37m"
    ANSI_RED      ="\033[0;31m"
    ANSI_LRED     = "\033[1;31m"
    ANSI_GREEN    = "\033[0;32m"
    ANSI_LGREEN   = "\033[1;32m"
    ANSI_BROWN    = "\033[0;33m"
    ANSI_YELLOW   = "\033[1;33m"
    ANSI_BLUE     = "\033[0;34m"
    ANSI_LBLUE    = "\033[1;34m"
    ANSI_PURPLE   = "\033[0;35m"
    ANSI_LPURPLE  = "\033[1;35m"
    ANSI_CYAN     = "\033[0;36m"
    ANSI_LCYAN    = "\033[1;36m"

    ANSI_BACKBLACK  = "\033[40m"
    ANSI_BACKRED    = "\033[41m"
    ANSI_BACKGREEN  = "\033[42m"
    ANSI_BACKYELLOW = "\033[43m"
    ANSI_BACKBLUE   = "\033[44m"
    ANSI_BACKPURPLE = "\033[45m"
    ANSI_BACKCYAN   = "\033[46m"
    ANSI_BACKGRAY   = "\033[47m"

    ANSI_RESET      = "\033[0m"
    ANSI_BOLD       = "\033[1m"
    ANSI_UNDERSCORE = "\033[4m"
    ANSI_BLINK      = "\033[5m"
    ANSI_REVERSE    = "\033[7m"
    ANSI_CONCEALED  = "\033[8m"

    XTERM_SET_TITLE   = "\033]2;"
    XTERM_END         = "\007"
    ITERM_SET_TAB     = "\033]1;"
    ITERM_END         = "\007"
    SCREEN_SET_STATUS = "\033]0;"
    SCREEN_END        = "\007"
  end
  
  begin # Custom Prompt
    if ENV['RAILS_ENV']
      name = "rails #{ENV['RAILS_ENV']}"
      colors = ANSI_BACKBLUE + ANSI_YELLOW
    else
      name = "ruby"
      colors = ANSI_BACKPURPLE + ANSI_YELLOW
    end

    if IRB and IRB.conf[:PROMPT]
      IRB.conf[:PROMPT][:SD] = {
        #:PROMPT_I => "#{colors}#{name}: %m #{ANSI_RESET}\n" \
        :PROMPT_I => "#{ENV['git_branch']}>",
        #             "#{name}: %m \n" \
        #           + ">> ", # normal prompt
        :PROMPT_S => "%l> ",  # string continuation
        :PROMPT_C => " > ",   # code continuation
        :PROMPT_N => " > ",   # code continuation too?
        :RETURN   => "#{ANSI_BOLD}# => %s  #{ANSI_RESET}\n\n",  # return value
        :AUTO_INDENT => true
      }
      IRB.conf[:PROMPT_MODE] = :SD
    end
  end
  
  false and begin # Colorize results
    require 'rubygems'
    require 'wirble'
    Wirble.init
    Wirble.colorize
  rescue
  end

  false and begin #format results
    require 'hirb'
    Hirb::View.enable
  rescue
  end
  
  begin # Tab completion
    require 'irb/completion'
  end

  begin # Utility methods
    def pm(obj, *options) # Print methods
      methods = obj.methods
      methods -= Object.methods unless options.include? :more
      filter = options.select {|opt| opt.kind_of? Regexp}.first
      methods = methods.select {|name| name =~ filter} if filter

      data = methods.sort.collect do |name|
        method = obj.method(name)
        if method.arity == 0
          args = "()"
        elsif method.arity > 0
          n = method.arity
          args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")})"
        elsif method.arity < 0
          n = -method.arity
          args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")}, ...)"
        end
        klass = $1 if method.inspect =~ /Method: (.*?)#/
        [name, args, klass]
      end
      max_name = data.collect {|item| item[0].size}.max
      max_args = data.collect {|item| item[1].size}.max
      data.each do |item| 
        print " #{ANSI_BOLD}#{item[0].rjust(max_name)}#{ANSI_RESET}"
        print "#{ANSI_GRAY}#{item[1].ljust(max_args)}#{ANSI_RESET}"
        print "   #{ANSI_LGRAY}#{item[2]}#{ANSI_RESET}\n"
      end
      data.size
    end
  end
  
  begin
    # thanks:
    # http://stefankst.net/2007/06/05/capture-standard-output-in-ruby/
    # http://judofyr.net/posts/copy-paste-irb.html
    # stick in .irbrc
    def copy(str=nil)
       if block_given?
         old_stdout = $stdout
         output_str = StringIO.new
         $stdout = output_str
         begin
            yield
         ensure
            $stdout = old_stdout
         end
         str=output_str.string
       end
       IO.popen('pbcopy', 'w') { |f| f << str.to_s } unless str.nil?
    end

    def paste
      `pbpaste`
    end

    def ep
      eval(paste)
    end
  end
  
  #don't have readline working
  #ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

  def disable_logger
    ActiveRecord::Base.logger.level = Logger::DEBUG
  end
# if ENV['RAILS_ENV']
#   # Called after the irb session is initialized and Rails has been loaded
#   IRB.conf[:IRB_RC] = Proc.new do
#     logger = Logger.new(STDOUT)
#     ActiveRecord::Base.logger = logger
#     ActiveResource::Base.logger = logger
#     ActiveResource::Base.logger.level = Logger::DEBUG
#   end
# end

  IRB_RC_HAS_LOADED = true
end

