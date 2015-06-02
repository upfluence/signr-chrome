signr = require('app/module/signr')
gmail_page = require('app/module/gmail')
cto = require('app/module/call_to_action')

refresh = (f) ->
  if /in/.test(document.readyState) || undefined == Gmail
    setTimeout ->
      refresh(f)
    , 100
  else
    f()

main = ->
  user_infos =  gmail_page.extractUserInfos()
  signr.isEnabled(user_infos).then(
    debugger
  ).fail(->
    cto.display()
  )

refresh main
