img=$(mktemp)

if curl 'https://www.sourcesplash.com/i/random' --output "$img"
then
  mkdir -p ~/Pictures/Wallpapers/
  mv "$img" ~/Pictures/Wallpapers/current.jpeg
fi

awww img ~/Pictures/Wallpapers/current.jpeg
