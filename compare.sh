#!/usr/bin/env bash

#
# Name: compare.sh
#
# Purpose: Compare and display stats for two (or more) players that are being tracked on https://pubgtracker.com.
#

#
# Print column headers
#
echo "Player Name  K/D Ratio  Skill Rating  Win %"
echo "-----------  ---------  ------------  -----"

#
# Main loop
#
while read player
do
  curl -x GET "https://pubgtracker.com/api/profile/pc/$player" \
  --header $pubg_api_key > data
done < players




