signr = require('app/module/signr')
cta = require('app/module/call_to_action')
page = require('app/module/gmail-page')
app = require('app/module/app')

app.execute_when_ready(-> app.run(page, signr, cta))
