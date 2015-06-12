# Description
#   Excepts HTTP POSTs to alert specific rooms
#
# Configuration:
#   HUBOT_ALERT_TOKEN - string that will be used in your request
#
# Author:
#   John Wright

LEVELS = ['debug', 'verbose', 'info', 'warn', 'error']
TOKEN = process.env.HUBOT_ALERT_TOKEN

originOf = (req) ->
  req.header.origin or req.header['x-forwarded-for'] or req.ip

authenticate = (req, res, next) ->
  if req.params.token isnt TOKEN
    return next 'Unauthorized'
  next()

getAlertFromRequest = (req, res, next) ->
  try
    data = if req.body.payload? then JSON.parse req.body.payload else req.body
  catch e
    return next 'Cannot parse request'
  errors = []
  {rooms, level, message} = data
  errors.push 'Need to specify what rooms' unless rooms?
  errors.push 'Need to specify a message' unless message?
  if errors.length
    return next errors
  level = 'info' unless level in LEVELS
  rooms = rooms.split ',' if typeof rooms is 'string'
  req.alert =
    level: level
    rooms: rooms
    message: message
  next()

getLevelEmoji = (level) ->
  switch level
    when 'debug' then ':bug:'
    when 'verbose' then ':loudspeaker:'
    when 'info' then ':information_source:'
    when 'warn' then ':warning:'
    when 'error' then ':rotating_light:'

module.exports = (robot) ->
  unless TOKEN?
    return robot.emit 'error', new Error 'Missing required HUBOT_ALERT_TOKEN variable'

  robot.router.post '/hubot/alert/:token', authenticate, getAlertFromRequest, (req, res) ->
    {alert} = req
    alert.rooms.forEach (room) ->
      robot.messageRoom room, """
        External message recieved from #{originOf req}
        #{getLevelEmoji alert.level} #{alert.message}
      """
    res.send 'Alerted'
