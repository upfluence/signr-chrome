cta = require('app/module/call_to_action')
signr = require('app/module/signr')
app = require('app/module/app')
page = require('app/module/inbox-page')

app.execute_when_ready(-> app.run(page, signr, cta))
