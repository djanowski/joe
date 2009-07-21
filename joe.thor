# module: joe

require 'fileutils'
require 'erb'

class Joe < Thor
  include Thor::Actions

  desc "gemspec", "Generate the gemspec file out of the ERb template"
  def gemspec
    template "#{spec_file}.erb", spec_file, :force => true
  end

  def spec_file
    Dir["*.gemspec"].first || Dir["*.gemspec.erb"].first.sub(/\.erb$/, '')
  end

  desc "package", "Build the gem, package it and create a .tar.gz archive"
  def package
    build and archive
  end

  desc "build", "Build the gem"
  def build
    gemspec

    if file = `gem build #{spec_file}`[/  File: (.*)/, 1]
      FileUtils.mkdir_p("pkg")
      FileUtils.mv(file, "pkg")

      say_status :created, gem_file
      true
    else
      say "Unable to build #{gem_file}"
      false
    end
  end

  desc "archive", "Create a .tar.gz archive out of the current HEAD"
  def archive
    if system "git archive --prefix=#{spec.name}-#{spec.version}/ --format=tar HEAD | gzip > #{archive_file}"
      say_status :archived, archive_file
      true
    end
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

  desc "release", "Publish gem and tarball to RubyForge"
  method_options(:project => :string, :package => :string)
  def release
    package and
    release_file(gem_file) and
    release_file(archive_file)
  end

  def self.source_root
    "."
  end

protected

  def artifact(extension)
    "pkg/#{spec.name}-#{spec.version}#{extension}"
  end

  def gem_file
    artifact(".gem")
  end

  def archive_file
    artifact(".tar.gz")
  end

  def release_file(file)
    project_name = options[:project] || spec.rubyforge_project || spec.name
    package_name = options[:package] || spec.name

    say "Releasing #{file} to RubyForge... (Project: #{project_name} Package: #{package_name})"

    if system "rubyforge add_release #{project_name} #{package_name} #{spec.version} #{file}"
      say_status :released, file
      true
    end
  end
end
