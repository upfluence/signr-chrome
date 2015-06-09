cta = require('app/module/call_to_action')
signr = require('app/module/signr')
inbox = require('app/module/inbox')

main = ->
  core.extractUserInfos(page).then((user) ->
    signr.isEnabled(user).then(->
      signr.fetchSnippet(user).then((snippet)->
        core.enableInjection(snippet, page)
      )
    ).fail(->
      cta.display()
    )

setTimeout(main, 500)
