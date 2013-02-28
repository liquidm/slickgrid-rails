#!/usr/bin/env rake
require "bundler/gem_tasks"

namespace :slickgrid do
  desc "Update SlickGrid library from current master"
  task :update => "tmp/SlickGrid" do
    cd "tmp/SlickGrid" do
      js_files = Dir.glob("*.js") +
        Dir.glob("plugins/*.js") +
        Dir.glob("controls/*.js")

      js_files.each do |file|
        mkdir_p "../../vendor/assets/javascript/slick/#{File.dirname(file)}"
        sh "cp #{file} ../../vendor/assets/javascripts/slick/#{file.gsub("slick.", "")}"
      end

      css_files = Dir.glob("*.css") +
        Dir.glob("plugins/*.css") +
        Dir.glob("controls/*.css")

      css_files.each do |file|
        mkdir_p "../../vendor/assets/stylesheets/slick/#{File.dirname(file)}"
        sh "cp #{file} ../../vendor/assets/stylesheets/slick/#{file.gsub("slick.", "")}"
      end
    end
  end

  file "tmp/SlickGrid" do
    mkdir_p "tmp"

    cd "tmp" do
      sh "git clone https://github.com/mleibman/SlickGrid.git"
    end
  end
end
