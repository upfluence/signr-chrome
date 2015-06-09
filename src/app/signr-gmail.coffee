signr = require('app/module/signr')
cta = require('app/module/call_to_action')
core = require('app/module/core')
page = require('app/module/gmail-page')

refresh = (f) ->
  if /in/.test(document.readyState)
    setTimeout ->
        refresh(f)
      , 100
  else
    f()

main = ->
  core.extractUserInfos(page).then((user)->
    signr.isEnabled(user).then(->
      signr.fetchSnippet(user).then((snippet) ->
        core.enableInjection(snippet, page)
      )
    ).fail(->
      cta.display()
    )
  )

refresh main, 500
