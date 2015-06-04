var self = require("sdk/self");
var mod = require("sdk/page-mod");

var pageMod = mod.PageMod({
  include: "https://mail.google.com/*",
  contentScriptFile: [self.data.url('gmail.js'), self.data.url('signr-gmail.js')]
})
