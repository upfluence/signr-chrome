cta = require('app/module/call_to_action')
signr = require('app/module/signr')
inbox = require('app/module/inbox')

inbox.extractUserInfos().then((user) ->
  signr.isEnabled(user).then(->
    console.log('HEY YOU ARE A SIGNR SENDER')
  ).fail(->
    cta.display()
  )
)
