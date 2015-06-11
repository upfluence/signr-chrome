$ = require('jquery')

extractUserInfos = (page) ->
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

enableInjection = (snippet, page) ->
  page.onCompose((evt) -> page.injectSnippet(evt.target, snippet))
  page.injectSnippet(element, snippet) for element in page.composes()

module.exports =
  execute_when_ready: (callback) ->
    self = @
    if /in/.test(document.readyState)
      setTimeout ->
          self.execute_when_ready(callback)
        , 100
    else
      callback()

  run: (page, signr, cta) ->
    extractUserInfos(page).then((user) ->
      signr.isEnabled(user).then(->
        signr.fetchSnippet(user).then((snippet)->
          enableInjection(snippet, page)
        ).fail(->
          # Catch silenty, no snippets are available
        )
      ).fail(->
        cta.display()
      )
    )
