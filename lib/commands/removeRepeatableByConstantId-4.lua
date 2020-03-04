--[[

  Remove a repeatable job by constantId:

    Input:
      KEYS[1] 'repeatableQueueKey',
      KEYS[2] 'repeatableJobKey',
      KEYS[3] 'constantIdKey',
      KEYS[4] 'jobReference',
]]

local repeatableQueueKey = KEYS[1]
local repeatableJobKey = KEYS[2]
local constantIdKey = KEYS[3]
local jobReference = KEYS[4]
local rcall = redis.call

rcall("ZREM", repeatableQueueKey, jobReference)
rcall("SREM", constantIdKey, jobReference)
rcall("DEL", repeatableJobKey)
