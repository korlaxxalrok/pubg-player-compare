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
source config

#
# Print column headers
#
echo "Player Name  K/D Ratio  Skill Rating  Win %"
echo "-----------  ---------  ------------  -----"

#
# Main loop
#
while read p
do	
  # cURL and save the output
  curl -s --request GET "https://pubgtracker.com/api/profile/pc/$p" \
  --header "${pubg_api_key}" | jq '.' > data.json

  # Process with jq until we have a slimmed down JSON object to work with
  jq '.Stats[] | select(.Region == "agg")' data.json > filtered1.json
  jq '. | select(.Season == "2017-pre2")' filtered1.json > filtered2.json
  jq '. | select(.Match == "solo")' filtered2.json > filtered_final.json

  # Filter for statistics and assign to variables
  kd_ratio=$(jq -r '.Stats[0].displayValue' filtered_final.json)
  rating=$(jq -r '.Stats[9].displayValue' filtered_final.json)
  win_percentage=$(jq -r '.Stats[1].displayValue' filtered_final.json)

  # Output data
  # test
  echo "${p} ${kd_ratio} ${rating} ${win_percentage}"

done < players
# TODO - Create examples dir for config and players files (necessary?)
# TODO - Spruce up repo
# TODO - Call 'er' Dunn




