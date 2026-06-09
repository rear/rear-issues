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
max_attempts="${GH2MD_MAX_ATTEMPTS:-5}"
retry_delay_seconds="${GH2MD_RETRY_DELAY_SECONDS:-15}"
gh2md_succeeded=0

for ((attempt=1; attempt<=max_attempts; attempt++))
do
  rm -rf issues
  if gh2md --multiple-files --idempotent --file-extension .gfm rear/rear issues ; then
    gh2md_succeeded=1
    break
  fi

  if [[ $attempt -lt $max_attempts ]] ; then
    echo "WARN: gh2md attempt ${attempt}/${max_attempts} failed - retrying in ${retry_delay_seconds}s"
    sleep "$retry_delay_seconds"
  fi
done

if [[ $gh2md_succeeded -eq 0 ]] ; then
  if [[ -d issues.old ]] ; then
    echo "WARN: gh2md failed after ${max_attempts} attempts - using existing issues from issues.old"
    mkdir -p issues
    cp issues.old/*.md issues/
  else
    echo "ERROR: gh2md failed after ${max_attempts} attempts and no issues.old fallback exists"
    exit 1
  fi
fi

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
for f in $(ls ./*.md 2>/dev/null)
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
