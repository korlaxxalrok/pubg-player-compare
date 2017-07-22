# pubg-player-compare

A simple script to compare some basic stats of players being tracked on [PUBG Tracker](https://pubgtracker.com). Also an experiment to get to know [jq](https://stedolan.github.io/jq/) a little bit better.

#### Goal:
* Select two users with stats on [PUBG Tracker](https://pubgtracker.com).
* Make (throttled) API calls to get their stats.
* Compare and display the selected stats

#### Reguirements:
* Bash
* An API key from [PUBG Tracker](https://pubgtracker.com/site-api). You will need to sign up to obtain the key.
* Two player nicknames from the pubg tracker. You can grab some easily from the leaderboard section.

#### Usage:
* Clone the repo locally: ```https://github.com/korlaxxalrok/pubg-player-compare.git```
* Create and populate two files in the root of the repository that are referenced by the script. You'll need to replace this information with your own API key and player names. You can also directly edit the files, of course.
  * ```touch config && touch players```
  * ```echo pubg_api_key='"[your_api_key_goes_here]"' > config```
  * ```echo [player1] >> players; echo [player2] >> players``` 
* Make the script executable: ```chmod u+x compare.sh```
* Run it! ```./compare.sh```

If all goes well you may see output like this (player names are hidden in this example).
```
Player Name          K/D Ratio            Skill Rating         Win %
-----------          ---------            ------------         -----
player1              3.36                 2,958.55             17.2%
player2              2.17                 1,590.71             5.3%
```

#### How does this work?
1. Makes a call to the PUBG Tracker API for a user, processes the unruly JSON that is returned with `jq`, and saves it to a file.
3. Refines the JSON so that we end up with stats from region "agg", season "2017-pre2", and match "solo".
* This is achieved by filtering the large (4K+ lines) JSON object that is returned in the request that we saved to a file. To work around some issues I had doing this inline with `jq`, I decided to apply the filter operations in sequence, writing a newly filtered file to disk each time. The last file becomes the refined JSON that is then used to extract the key values from.
4. Extracts (with `jq`) the keys from known (and hopefully consistent) indexes in the refined JSON object.
5. Assigns these key values to variables.
6. Outputs the results to stdout with some basic formatting.
7. Repeats for the next user in the `players` file.

#### Take away:
* `jq` is a very nice tool that allows for doing some nify things with JSON from the (relatively) comfy world of Bash. I looked at several resources when doing research, and they were typically good, but I found this tutorial to be really clear and useful: [Reshaping JSON with jq](http://programminghistorian.org/lessons/json-and-jq) There are other nuggets to be found here. Worth a look.

#### MEGABONUS:
If you actually find this really specific script useful you can add more players to the `players` file. This script will pretty happily churn though that list and output the stats for each user. It'll take a while as there is a 2 second sleep step in the loop, but hey, go for it :)
