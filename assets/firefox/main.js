var self = require("sdk/self");
var mod = require("sdk/page-mod");

var gmail_mod = mod.PageMod({
  include: "https://mail.google.com/*",
  contentScriptFile: [self.data.url('signr-gmail.js')]
})

var inbox_mod = mod.PageMod({
  include: "https://inbox.google.com/*",
  contentScriptFile: [self.data.url('signr-inbox.js')]
})
