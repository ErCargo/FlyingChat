const path = require('path');

module.exports = {
  port: 7410,
  dbFolder: path.join(__dirname, './database/'),
  logFilePath: path.join(__dirname, './logs/'),
  sessionSecret: 'abcafdafafdasfdasfsa',
  enableGzip: true,
  gzipOptions: {}
};
