#!/usr/bin/env ruby
require 'bundler'

vendored_lib = Gem::Specification.find_by_name('bundler').gem_dir
$:.unshift File.join(vendored_lib, 'lib', 'bundler', 'vendor')
require 'bundler/vendor/net/http/persistent'

module ExtraThreadInformation
  def connection_for uri
    # Add a thread variable to bundler's net/http/persistent 
    # to log requests used by this thread.
    key = ['net_http_persistent', @name].compact
    request_info_key = [key, 'request_uris'].join('_').intern

    Thread.current[request_info_key] ||= []
    Thread.current[request_info_key] +=  [uri]

    super uri
  end
end

Net::HTTP::Persistent.send(:prepend, ExtraThreadInformation)

trap(:INFO) {
  threads = Thread.list
  
  # Select threads that are either shelling out currently, or trying a Net::HTTP#connect
  # Matches stack traces that either match:
  #   - "in `connect'"
  #   - "in ``'"
  #
  # Somewhat crude and not precise, but it should only be inclusive to false positives,
  # which is fine for this, and should be apparent from the rest of the stack trace.
  working_threads = threads.select do |t|
    t.backtrace.first =~ /in `(connect|`)'$/
  end

  puts
  puts
  puts "Thread Count:     #{threads.count}"
  puts "Working Threads:  #{working_threads.count}"
  puts

  threads.each do |t|
    # Highlight working (stalled) threads
    color = working_threads.detect {|wt| wt.object_id == t.object_id } ? "\e[36m" : ''
    puts color + "#" * 50
     # Comment out this line and use the following line for a more concise output 
     # (though the first is preferred when reporting an issue)
    puts t.backtrace
    # puts t.backtrace.first
    
    # Report on Thread specific variables
    puts t.keys.inspect
    t.keys.each do |t_key|
      puts "#{t_key}: #{t[t_key]}"
    end
    puts "#" * 50 + "\e[0m"
  end

  puts
}
