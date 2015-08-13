chromeSupport = require('app/support/chrome')

chromeSupport.onInstalled(->
  chromeSupport.openTab("https://mail.google.com")
)
