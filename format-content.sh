#!/usr/bin/env zsh

author=${1:-"Luísa Coelho"}

for i in content/blog_pt_br/*.md; do
    mv -- "$i" "${i%.md}.pt.md";
    mv content/blog_pt_br/*.pt.md content/blog/
done

for i in content/blog/20*; do
    sed -i "4s/+++/\n[taxonomies]\nauthors = [\"$author\"]\n+++/1" $i
done
