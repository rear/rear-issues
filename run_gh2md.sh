#!/bin/bash

echo "installing gh2md with pipx"
pipx install gh2md

export PATH=$PATH:$HOME/.local/bin:/home/ubuntu/.local/bin

if [[ ! -d docs ]] ; then
	echo "ERROR: Directory $PWD does not have a 'docs' directory"
       	exit 1
fi

# ReaR-User-Guide docs reside under the docs/ directory
cd docs || exit 1

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

cd issues || exit 1
# remove the old index file
rm -f index.md

# Create an header
echo -e "# Issues History of Relax-and-Recover (ReaR)\n" > index.md

# create a new index file
for f in $(ls *.md 2>/dev/null)
do
  part1="$(head -1 "$f" | cut -d'(' -f 1)"
  echo "$part1" | grep -q ^\#
  if [[ $? -eq 0 ]] ; then
     # remove the '#' to avoid capital lines in the index file
     part1="$(echo "$part1" | cut -d'#' -f 2-)"
  fi
  part2="$(head -1 "$f" | cut -d')' -f 2)"
  echo "- ${part1}($f)${part2}" >> index.md
done

