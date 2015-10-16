chromeSupport = require('app/support/chrome')

chromeSupport.extendCSP()

chromeSupport.onInstalled(->
  chromeSupport.openTab("https://mail.google.com")
)
