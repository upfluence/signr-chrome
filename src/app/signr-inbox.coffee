require('app/module/opbeat')
cta = require('app/module/call_to_action')
signr = require('app/module/signr')
page = require('app/module/inbox-page')
menus = require('app/module/google-menus')
app = require('app/module/app')

app.execute_when_ready(-> app.run(page, menus, signr, cta))
