# ReaR-User-Guide docs reside under the docs/ directory
cd  docs

[[ -d issues.old ]] && rm -rf issues.old
[[ -d issues ]] && mv issues issues.old


# run gh2md which will create a fresh issues directory with content
gh2md --multiple-files --idempotent --file-extension .gfm rear/rear issues

find issues/ -type f | while read f
do
  b="${f%.*}"
  [[ ! -f "$b.md" ]] && pandoc --verbose -f gfm+hard_line_breaks -t markdown_strict "$b.gfm" -o "$b.md"
  rm -f "$b.gfm"
done

# To have all issues we copy the content of issues.old in issues/ as well
# as not all issues are dumped by a gh2md run
[[ -d issues.old ]] && cp issues.old/*.md issues/

cd issues
# remove the old index file
rm -f index.md

# Create an header
echo -e "# Issues History of Relax-and-Recover (ReaR)\n" > index.md

# create a new index file
for f in $(ls *.md)
do
  part1="$(head -1 $f | cut -d'(' -f 1)"
  part2="$(head -1 $f | cut -d')' -f 2)"
  echo "- ${part1}($f)${part2}" >> index.md
done

