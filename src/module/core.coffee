$ = require('jquery')

module.exports =
  extractUserInfos:(page) ->
    $.Deferred((defer) ->
      page.emailAliases((aliases)->
        defer.resolve(
          picture: page.imageUrl(),
          primary: page.email(),
          name: page.name()
          aliases: aliases
        )
      )
    ).promise()

  enableInjection: (snippet, page) ->
    page.onCompose((evt) -> page.injectSnippet(evt.target, snippet))
    page.injectSnippet(element, snippet) for element in page.composes()
