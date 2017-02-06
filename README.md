# hubot-alert

[![Greenkeeper badge](https://badges.greenkeeper.io/johngeorgewright/hubot-alert.svg)](https://greenkeeper.io/)

Excepts HTTP POSTs to alert specific rooms

## Installation

In hubot project repo, run:

`npm install hubot-alert --save`

Then add **hubot-alert** to your `external-scripts.json`:

```json
["hubot-alert"]
```

Export `HUBOT_ALERT_TOKEN`:

```
export HUBOT_ALERT_TOKEN=mysecrettoken
```

## Sample Interaction

```
POST /hubot/alert/mysecrettoken
level:    'error'  # Can be one of debug, verbose, info, warn or error
rooms:    'shell'  # CSV of rooms to alert
message:  'Some message to tell everyone'
```

The above request will alert the "shell" room with:

```
External message received from xxx.xxx.xxx.xxx
:rotating_light: Some message to tell everyone
```
