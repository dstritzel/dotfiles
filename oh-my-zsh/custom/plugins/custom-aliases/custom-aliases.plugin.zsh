
# Replace use fd as an alias for fdfind if fd does not exist
if [[ -f '/usr/bin/fdfind' && ! -z '/usr/bin/fd' ]]; then
  alias fd='/usr/bin/fdfind'
fi
