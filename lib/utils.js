'use strict';
const crypto = require('crypto');
const errorObject = { value: null };
function tryCatch(fn, ctx, args) {
  try {
    return fn.apply(ctx, args);
  } catch (e) {
    errorObject.value = e;
    return errorObject;
  }
}

function isEmpty(obj) {
  for (const key in obj) {
    if (obj.hasOwnProperty(key)) {
      return false;
    }
  }
  return true;
}

/**
 * Waits for a redis client to be ready.
 * @param {Redis} redis client
 */
function isRedisReady(client) {
  return new Promise((resolve, reject) => {
    if (client.status === 'ready') {
      resolve();
    } else {
      function handleReady() {
        client.removeListener('error', handleError);
        resolve();
      }

      function handleError(err) {
        client.removeListener('ready', handleReady);
        reject(err);
      }

      client.once('ready', handleReady);
      client.once('error', handleError);
    }
  });
}

function getConstantIdKey(constantId) {
  return 'bull:const:' + md5(constantId);
}

function getRepeatableQueueKey(queueName) {
  return "bull:" + queueName + ":delayed";
}

function getRepeatableJobKey(queueName, jobId) {
  return "bull:" + queueName + ":" + jobId
}

function md5(str) {
  return crypto.createHash('md5').update(str).digest('hex');
}

module.exports.errorObject = errorObject;
module.exports.tryCatch = tryCatch;
module.exports.isEmpty = isEmpty;
module.exports.isRedisReady = isRedisReady;
module.exports.getConstantIdKey = getConstantIdKey;
module.exports.getRepeatableQueueKey = getRepeatableQueueKey;
module.exports.getRepeatableJobKey = getRepeatableJobKey;
module.exports.md5 = md5;
