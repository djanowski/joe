# module: joe

require 'fileutils'
require 'erb'

class Joe < Thor
  desc "gemspec", "Generate the gemspec file out of the ERb template"
  def gemspec
    File.open(spec_file, 'w') do |f|
      f.write(ERB.new(File.read("#{spec_file}.erb")).result(binding))
    end

    puts "Successfully generated #{spec_file}"
    true
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
      FileUtils.mv(file, "pkg")
    end

    puts "Successfully built #{gem_file}"
    true
  end

  desc "archive", "Create a .tar.gz archive out of the current HEAD"
  def archive
    if system "git archive --prefix=#{spec.name}-#{spec.version}/ --format=tar HEAD | gzip > #{archive_file}"
      puts "Successfully archived to #{archive_file}"
      true
    end
  end

  def spec
    @spec ||= 
      begin
        @spec = eval(File.read(spec_file))
      rescue Errno::ENOENT
        $stderr.puts "Gem specification file #{spec_file} not found."
        exit 1
      end
  end

  desc "release", "Publish gem and tarball to RubyForge"
  def release
    package and
    release_file(gem_file) and
    release_file(archive_file)
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
    puts "Releasing #{file} to RubyForge..."

    if system "rubyforge add_release #{spec.name} #{spec.name} #{spec.version} #{file}"
      puts "Successfully released #{file} to RubyForge."
      true
    end
  end
end
