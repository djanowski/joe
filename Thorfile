class Joe < Thor
  desc "deploy", "Deploys Joe"
  def deploy
    system "scp joe.thor sample.gemspec.erb dimaion.com:www/joe/"
    install_joe
  end

  desc "install_joe", "Installs the local copy of Joe"
  def install_joe
    invoke :install, "http://dimaion.com/joe/joe.thor"
  end
end
