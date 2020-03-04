--[[

  Update a constnatId set of jobIds:

    Input:
      KEYS[1] 'constantId',
      KEYS[2]  'jobId',
      KEYS[3]  'type',

]]

local constantId = tostring(KEYS[1])
local jobId = tostring(KEYS[2])
local type = tostring(KEYS[3])
local rcall = redis.call

if type == "remove" then
  rcall("SREM", constantId, jobId)
end
if type == "add" then
  rcall("SADD", constantId, jobId)
end
