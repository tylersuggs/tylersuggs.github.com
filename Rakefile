def jekyll(opts = "")
  sh "jekyll " + opts
end

def publish(file)
  return false unless File.exists?(file)
  prefix = File.dirname(__FILE__)
  date = Time.new
  base = File.basename(file, File.extname(file))
  slug = "#{date.strftime("%Y/%m/%d")}/#{base}/"
  
  FileUtils.mv File.join(prefix, file), File.join(prefix, "_posts/#{date.strftime("%Y-%m-%d")}-#{base}.md")
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
  task :new => [:require_input] do
    title = ask("Title: ")
    name = slugify(title)
    furi = "_drafts/#{name}.md"
    template = File.read "_lib/post_template.md"
    File.open(furi, "w+") do |f|
      f << template.gsub(/POST_TITLE/, title)
      end
      $stdout.puts "Created Draft: #{title}"
      sh "mate . && mate -l 6 #{furi}"
      sh "git add #{furi}"
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

task :require_input do
  begin
    require 'highline/import'
  rescue LoadError => e
    puts "\n - FATAL: highline gem is required."
    exit(1)
  end
end