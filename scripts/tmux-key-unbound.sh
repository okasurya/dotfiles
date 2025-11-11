#!/bin/bash

bound=$(tmux list-keys -T prefix 2>/dev/null | grep 'bind-key.*-T prefix [a-zA-Z] ' | sed 's/.*-T prefix \([a-zA-Z]\) .*/\1/' | sort | tr '\n' ' ')
all_letters="a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
echo "Bound keys: $bound"
echo ""
echo "Unbound letters:"
for letter in $all_letters; do
  if ! echo "$bound" | grep -q "$letter "; then
    echo -n "$letter "
  fi
done
echo
