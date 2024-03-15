#!/usr/bin/env zsh

author=${1:-"Luísa Coelho"}

for i in content/blog/20*; do
    sed -i "4s/+++/\n[taxonomies]\nauthors = [\"$author\"]\n+++/1" $i
done