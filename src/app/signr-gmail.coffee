signr = require('app/module/signr')
gmail = require('app/module/gmail')
cto = require('app/module/call_to_action')

refresh = (f) ->
  if /in/.test(document.readyState) || undefined == Gmail
    setTimeout -> refresh(f),
    100
  else
    f()

main = ->
  user = gmail.extractUserInfos()
  signr.isEnabled(user).then(->
    gmail.enableInjection(user)
  ).fail( ->
    cto.displayCallToAction()
  )

refresh main