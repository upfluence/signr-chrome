$ = require('jquery')
opbeat = require('app/module/opbeat')

extractUserInfos = (page, menus) ->
  $.Deferred((defer) ->
    page.emailAliases((aliases) ->
      defer.resolve(
        picture: menus.imageUrl(),
        primary: menus.email(),
        name: menus.name()
        aliases: aliases
      )
    )
  ).promise()

enableInjection = (snippet, page) ->
  page.onCompose((evt) -> page.injectSnippet(evt.target, snippet))
  page.injectSnippet(element, snippet) for element in page.composes()

_run = (page, menus, signr, cta) ->
  extractUserInfos(page, menus).then((user) ->
    opbeat.setUserContext(email: user.primary, name: user.name)
    signr.isEnabled(user).done( ->
      signr.fetchSnippet(user).done((snippet) ->
        enableInjection(snippet, page)
      ).fail((xhr) ->
        opbeat.handleXhrError(xhr)
      )
    ).fail((xhr) ->
      opbeat.handleXhrError(xhr)
      cta.display() if xhr.status == 404
    )
  )

module.exports =
  execute_when_ready: (callback) ->
    self = @
    if /in/.test(document.readyState)
      setTimeout ->
          self.execute_when_ready(callback)
        , 100
    else
      callback()

  run: (page, menus, signr, cta) ->
    try
      _run(page, menus, signr, cta)
    catch e
      opbeat.captureException(e.stack)
