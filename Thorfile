class Joe < Thor
  def deploy
    system "scp joe.thor sample.gemspec.erb dimaion.com:www/joe/"
    install
  end

  def install
    system "thor install http://dimaion.com/joe/joe.thor"
  end
end
