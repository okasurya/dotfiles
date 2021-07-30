#!/bin/sh

rofi -run-list-command ". ~/bin/alias.sh" -run-command "/bin/zsh -i -c '{cmd}'" -show run
