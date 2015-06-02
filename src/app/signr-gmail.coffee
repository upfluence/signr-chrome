signr = require('app/module/signr')
gmail_page = require('app/module/gmail')

refresh = (f) ->
  if /in/.test(document.readyState) || undefined == Gmail
    setTimeout ->
      refresh(f)
    , 100
  else
    f()

main = ->
  user_infos =  gmail_page.extractUserInfos()
  debugger

refresh main
