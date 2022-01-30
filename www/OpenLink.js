var exec = require('cordova/exec');

module.exports.chrome = function(arg0, success, error) {
    exec(success, error, 'OpenLink', 'chrome', [arg0]);
};

module.exports.safari = function(arg0, success, error) {
    exec(success, error, 'OpenLink', 'safari', [arg0]);
};