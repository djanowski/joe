class Joe < Thor
  def deploy
    system "scp joe.thor dimaion.com:www/files/"
    install
  end

  def install
    system "thor install http://dimaion.com/files/joe.thor"
  end
end
