require "thor"
require 'fileutils'
require 'erb'
require 'rubygems/gem_runner'

class Joe < Thor
  VERSION = "0.0.2"

  include Thor::Actions

  desc "gemspec", "Generate the gemspec file out of the ERb template"
  def gemspec
    template "#{spec_file}.erb", spec_file, :force => true
  end

  desc "install", "Build the gem, package it and install it"
  def install
    build and
      gem "install", gem_file
  end

  desc "build", "Build the gem"
  def build
    gemspec if File.exists?("#{spec_file}.erb")

    gem "build", spec_file

    if pkg(gem_file)
      say_status :created, gem_file
      true
    else
      say "Unable to build #{gem_file}"
      false
    end
  end

  desc "archive", "Create a .tar.gz archive out of the current HEAD"
  def archive
    if system("git archive --prefix=#{spec.name}-#{spec.version}/ --format=tar HEAD | gzip > #{archive_file}") && pkg(archive_file)
      say_status :created, archive_file
      true
    end
  end

  desc "release", "Publish gem to RubyGems.org"
  def release
    build
    say "Releasing #{gem_file}..."
    gem "push", "pkg/#{gem_file}"
  end

  def self.source_root
    "."
  end

protected

  def pkg(file)
    FileUtils.mkdir_p("pkg")
    File.exist?(file) && FileUtils.mv(file, "pkg")
  end

  def spec_file
    Dir["*.gemspec"].first || Dir["*.gemspec.erb"].first.sub(/\.erb$/, '')
  end

  def spec
    @spec ||=
      begin
        @spec = eval(File.read(spec_file))
      rescue Errno::ENOENT
        say_status :not_found, spec_file
        exit 1
      end
  end

  def gem_file
    spec.file_name
  end

  def archive_file
    gem_file.sub(/\.gem$/, ".tar.gz")
  end

  def gem(*args)
    Gem::GemRunner.new.run(args)
  end
end
