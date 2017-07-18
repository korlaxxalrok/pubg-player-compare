#!/usr/bin/env bash

#
# Name: compare.sh
#
# Purpose: Compare and display stats for two (or more) players that are being
# tracked on https://pubgtracker.com.
#

#
# Source the config for API key
#
. config

#
# Print column headers
#
printf "%-20s %-20s %-20s %-20s\n" "Player Name" "K/D Ratio" "Skill Rating" "Win %"
printf "%-20s %-20s %-20s %-20s\n" "-----------" "---------" "------------" "-----"

#
# Main loop
#
while read p
do  
  # cURL and save the output
  curl -s "https://pubgtracker.com/api/profile/pc/$p" \
  --header "${pubg_api_key}" | jq '.' > data.json

  # Process with jq until we have a slimmed down JSON object to work with
  jq '.Stats[] | select(.Region == "agg")' data.json > filtered_1.json
  jq '. | select(.Season == "2017-pre2")' filtered_1.json > filtered_2.json
  jq '. | select(.Match == "solo")' filtered_2.json > filtered_final.json

  # Filter for statistics and assign to variables
  kd_ratio=$(jq -r '.Stats[0].displayValue' filtered_final.json)
  rating=$(jq -r '.Stats[9].displayValue' filtered_final.json)
  win_percentage=$(jq -r '.Stats[1].displayValue' filtered_final.json)

  # Output data
  printf "%-20s %-20s %-20s %-20s\n" "${p}" "${kd_ratio}" "${rating}" "${win_percentage}"

  # Give the API a little break so we don't annoy the hosts 
  sleep 2

done < players
