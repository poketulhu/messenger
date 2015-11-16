names=["Sue L. Cole", "William A. Adams", "Joann K. Washington", "Elizabeth J. Rayford", "Marc L. Taylor"]

names.each do |name|
  User.create(name: name)
end
