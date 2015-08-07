require('app/module/opbeat')
signr = require('app/module/signr')
cta = require('app/module/call_to_action')
page = require('app/module/gmail-page')
menus = require('app/module/google-menus')
app = require('app/module/app')

app.execute_when_ready(-> app.run(page, menus, signr, cta))
