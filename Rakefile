require 'rubygems'
require 'json'
require 'open-uri'

API_URL = "http://tysug.gs/yourls-api.php"
API_SIG = "23808a8d51"

def jekyll(opts = "")
  sh "jekyll " + opts
end

def short_url(url)
  uri = URI.parse("#{API_URL}?signature=#{API_SIG}&action=shorturl&url=#{url}&format=json")
  json = JSON.parse(uri.open.read)

  return false unless json.has_key? 'shorturl'
  
  json['shorturl']
end


def publish(file)
  return false unless File.exists?(file)
  prefix = File.dirname(__FILE__)
  date = Time.new.strftime("%Y-%m-%d")
  base = File.basename file
  
  FileUtils.mv File.join(prefix, file), File.join(prefix, "_posts/#{date}-#{base}")
end

def slugify(title)
  title.gsub(/\s+/, '-').gsub(/[^a-zA-Z0-9_-]/, "").downcase
end

desc "Build site using Jekyll"
task :build do
  jekyll
end

namespace :post do
  desc "Create new post"
  task :new do
    print "Post title: "
    title = $stdin.gets.chomp.strip
    name = slugify(title)
    fn = "_drafts/#{name}.md"
    File.open(fn, "w+") do |file|
      file.puts <<-EOF
--- 
title: #{title}
layout: post
tags:
---
        EOF
      end
      $stdout.puts "Created #{fn}"
      system("mate", ".")
      system("mate", "-l 6", fn)
      system "git", "add", ".")
  end
  
  desc "Publish draft post"
  task :publish do
    drafts = Dir["_drafts/*.md"]
    drafts.each_with_index do |f, i|
      $stdout.puts "#{i+1}: #{File.basename f}"
    end
    print "Choose which draft to publish: "
    draft = $stdin.gets.chomp.strip.to_i
    file = drafts[draft-1]
    if publish(file)
      puts "Success: #{file} has been published!"
    else
      puts "FAIL!"
    end
  end
end
