#!/usr/bin/env bash -x

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
  jq '.Stats[] | select(.Region == "agg")' data.json > filtered.json
  jq '.[] | select(.Season == "2017-pre2")' data.json > filtered.json
  jq '.[] | select(.Match == "solo")' data.json > filtered.json
done < players




