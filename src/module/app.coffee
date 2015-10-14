opbeat = require('app/module/opbeat')

_run = (identity, injector, api, cta) ->
  identity.fetchUserInfos().done((user) ->
    opbeat.setUserContext(email: user.primary, name: user.name)
    api.isEnabled(user).done( ->
      api.fetchSnippet(user).done((currentSnippet) ->
        injector.enable(currentSnippet)
      ).fail((xhr) ->
        opbeat.handleXhrError(xhr)
      )
    ).fail((xhr) ->
      opbeat.handleXhrError(xhr)
      cta.display() if xhr.status == 404
    )
  )

module.exports =
  executeWhenReady: (callback) ->
    self = @
    if /in/.test(document.readyState)
      setTimeout ->
          self.executeWhenReady(callback)
        , 100
    else
      callback()

  run: (identity, injector, api, cta) ->
    try
      _run(identity, injector, api, cta)
    catch e
      opbeat.captureException(e.stack)
