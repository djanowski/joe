require "fileutils"
require "erb"
require "rubygems/gem_runner"

class Joe
  VERSION = "0.1.0"

  def gemspec
    File.open(spec_file, "w") do |f|
      f.write ERB.new(File.read("%s.erb" % spec_file), nil, "-").result

      status :write, spec_file
    end
  rescue SyntaxError
    fail "Parsing your gemspec failed. Please check its syntax."
  end

  def build
    gemspec if File.exist?("%s.erb" % spec_file)

    gem("build", spec_file)

    if pkg(gem_file)
      status :created, "pkg/#{gem_file}"
    else
      fail "Unable to build #{gem_file}"
    end
  end

  def install
    build and gem("install", "pkg/#{gem_file}")
  end

  def archive
    if git_archive && pkg(archive_file)
      status :created, "pkg/#{archive_file}"
    end
  end

  def release
    build
    status :releasing, gem_file
    gem("push", "pkg/#{gem_file}")
  end

private
  def pkg(file)
    FileUtils.mkdir_p("pkg")
    File.exist?(file) && FileUtils.mv(file, "pkg")
  end

  def spec_file
    Dir["*.gemspec"].first || Dir["*.gemspec.erb"].first.sub(/\.erb$/, "")
  end

  def fail(str)
    puts "\e[1;31m#{str}\e[1;37m"
  end

  def status(type, message)
    puts "\e[1;32m %10s \e[1;37m %s" % [type, message]

    return type, message
  end

  def gem(*args)
    Gem::GemRunner.new.run(args)
  end

  def spec
    @spec ||=
      begin
        @spec = eval(File.read(spec_file))
      rescue Errno::ENOENT
        log :not_found, spec_file
        exit 1
      end
  end

  def gem_file
    spec.file_name
  end

  def archive_file
    gem_file.sub(/\.gem$/, ".tar.gz")
  end

  def git_archive
    system("git archive --prefix=#{spec.name}-#{spec.version}/ " +
           "--format=tar HEAD | gzip > #{archive_file}")
  end
end
