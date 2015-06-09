cta = require('app/module/call_to_action')
signr = require('app/module/signr')
core = require('app/module/core')
page = require('app/module/inbox-page')

main = ->
  core.extractUserInfos(page).then((user) ->
    signr.isEnabled(user).then(->
      signr.fetchSnippet(user).then((snippet)->
        core.enableInjection(snippet, page)
      )
    ).fail(->
      cta.display()
    )
  )

setTimeout(main, 500)
