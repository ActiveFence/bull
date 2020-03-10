--[[

  Remove a repeatable job by constantId:

    Input:
      KEYS[1] 'repeatableQueueKey',
      KEYS[2] 'repeatableJobKey',
      KEYS[3] 'constantIdKey',
      ARGV[1] 'jobReference',
]]

local repeatableQueueKey = KEYS[1]
local repeatableJobKey = KEYS[2]
local constantIdKey = KEYS[3]
local jobReference = ARGV[1]
local rcall = redis.call

rcall("ZREM", repeatableQueueKey, jobReference)
rcall("SREM", constantIdKey, jobReference)
rcall("DEL", repeatableJobKey)
