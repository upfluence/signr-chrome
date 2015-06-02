signr = require('app/module/signr')

refresh = (f) ->
  if /in/.test(document.readyState) || undefined == Gmail
    setTimeout ->
      refresh(f)
    , 100
  else
    f()

main = ->

refresh main
