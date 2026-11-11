#!/bin/bash
set -e

BUCKET="$1"
BOOKDIR="$2"

mkdir -p "$BOOKDIR"

aws s3 cp "s3://$BUCKET/" "$BOOKDIR" --recursive --exclude "*" --include "*.txt"

BOOKDIR=$(realpath "$BOOKDIR")

echo "File path" > book_list.txt

find "$BOOKDIR" -name "*.txt" | sort >> book_list.txt

echo "Number of books: $(tail -n +2 book_list.txt | wc -l)"
