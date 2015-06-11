api = require('app/module/inbox-api')
signr = require('app/module/signr')
$ = require('jquery')

injectSnippet = (element, snippet) ->
  if $(element).find('.aR')
               .find('div[style*="border-color:#deadbe"]')
               .html() == undefined
    $(element).find('.aR').append(snippet.template)

module.exports =
  extractUserInfos: ->
    $.Deferred((defer) ->
      api.emailAliases((aliases)->
        defer.resolve(
          picture: api.imageUrl(),
          primary: api.email(),
          name: api.name()
          aliases: aliases
        )
      )
    ).promise()

  enableInjection: (user) ->
    signr.fetchSnippet(user).then((snippet) ->
      api.onCompose((evt) -> injectSnippet(evt.target, snippet))
      injectSnippet(element, snippet) for element in api.composes()
    )
