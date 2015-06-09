cta = require('app/module/call_to_action')
signr = require('app/module/signr')
inbox = require('app/module/inbox')

main = ->
  inbox.extractUserInfos().then((user) ->
    signr.isEnabled(user).then(->
      inbox.enableInjection(user)
    ).fail(->
      cta.display()
    )
  )

setTimeout(main, 500)
