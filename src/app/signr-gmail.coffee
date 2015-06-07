signr = require('app/module/signr')
gmail = require('app/module/gmail')
cta = require('app/module/call_to_action')

refresh = (f) ->
  if /in/.test(document.readyState) || undefined == Gmail
    setTimeout ->
      refresh(f)
    , 100
  else
    f()

main = ->
  gmail.extractUserInfos().then((user)->
    signr.isEnabled(user).then(->
      gmail.enableInjection(user)
    ).fail(->
      cta.display()
    )
  )

refresh main
