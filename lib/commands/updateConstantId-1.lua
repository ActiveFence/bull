--[[

  Update a constnatId set of jobIds:

    Input:
      KEYS[1] 'constantId',
      ARGV[1]  'jobId',
      ARGV[2]  'type',

]]

local constantId = tostring(KEYS[1])
local jobId = tostring(ARGV[1])
local type = tostring(ARGV[2])
local rcall = redis.call

if type == "remove" then
  rcall("SREM", constantId, jobId)
end
if type == "add" then
  rcall("SADD", constantId, jobId)
end
