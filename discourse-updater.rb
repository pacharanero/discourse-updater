#!/usr/bin/ruby
require 'yaml'
DISCOURSES = YAML::load_file('discourses.yml')

def update(discourse)
  puts "updating #{discourse} now"
  `ssh #{discourse} 'bash -s' < discourse-on-remote-update-script.sh`
  puts "completed update of #{discourse} \n\n"
end

def update_all_discourses
  DISCOURSES.each do |discourse|
    update(discourse)
  end
end

if ARGV
  if ARGV[0] == "all"
    update_all_discourses
  elsif DISCOURSES.include?(ARGV[0])
    update(ARGV[0])
  else
    puts "at least one known discourse must be specified, or use 'all' to update all"
  end
end
