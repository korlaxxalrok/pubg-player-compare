# pubg-player-compare

A simple script to compare some basic stats of players being tracked on [pubgtracker.com](https://pubgtracker.com). Also an experiment to get to know [jq](https://stedolan.github.io/jq/) a little bit better.

#### Goal:
* Select two users with stats on https://pubgtracker.com
* Make (throttled) API calls to get their stats
* Compare and display the selected stats

#### Reguirements:
* A *nix system with a Bash-like shell.
* An API key from [PUBG Tracker](https://pubgtracker.com/site-api) (You will need to sign up to obtain the key).
* Two player nicknames from the pubg tracker (You can grab some easily from the leaderboard section).

#### Usage:
* Clone the repo locally: ```$> https://github.com/korlaxxalrok/pubg-player-compare.git```
* Copy the example `config` and `players` files from the `/examples` directory to the root of the repository directory.
* Edit the files, adding your API key and the players you want to compare.
* Make the script executable: ```$> chmod +x compare.sh```
* Run it! ```$> ./compare.sh```

If all goes well you may see output like this (player names are hidden).
```
Player Name          K/D Ratio            Skill Rating         Win %
-----------          ---------            ------------         -----
player1              3.36                 2,958.55             17.2%
player2              2.17                 1,590.71             5.3%
```

#### How does this work?
1. Make a call to the API for a user.
2. Process the unruly JSON that is returned with `jq` and save it in a file.
3. Refine the JSON so that we end up with stats from region "agg", season "2017-pre2", and match "solo".
* This is achieved by filtering the large (4K+ lines) JSON object that is returned in the request. To work around some issues I had doing this inline with `jq`, I decided to apply the filter operations in sequence, writing a new filter file to disk each time. The last file becomes the refined JSON that is then used to extract the key values from.
4. Extract keys from know indexes in the refined JSON object with `jq`.
5. Assign these values to variables.
6. Output to stdout with some basic formatting.
7. Repeat for the next user in the `players` file.

#### Take away:
* `jq` is a very nice tool that allows for doing some nify things with JSON from the (relatively) comfy world of Bash. I looked at several resources when doing research, and they were typically good, but I found this tutorial to be really clear and useful: [Reshaping JSON with jq](http://programminghistorian.org/lessons/json-and-jq) There are other nuggets to be found here. Worth a look.
