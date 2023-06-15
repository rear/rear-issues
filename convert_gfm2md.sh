find issues/ -type f | while read f
do
  b="${f%.*}"
  #mv -v "$b.md" "$b.gfm"
   [[ ! -f "$b.md" ]] && pandoc --verbose -f gfm+hard_line_breaks -t markdown_strict "$b.gfm" -o "$b.md"
   rm -f "$b.gfm"
done

cd issues
rm -f index.md
for f in $(ls *.md)
do
  part1="$(head -1 $f | cut -d'(' -f 1)"
  part2="$(head -1 $f | cut -d')' -f 2)"
  echo "${part1}($f)${part2}" >> index.md
done

