require('bower_components/opbeat-js/dist/opbeat.js')
env = require('app/module/environment')

window.Opbeat.config(
  orgId: '9fab231fcf4d4dcd9cd6d8e5ab4a4841',
  appId: 'badf3dcff7'
)

module.exports =
  setUserContext: (ctx) ->
    Opbeat.setUserContext(ctx)

  captureException: (e) ->
    Opbeat.captureException(e) if env.production()

  handleXhrError: (xhr) ->
    if xhr.status != 404 && env.production()
      Opbeat.captureException(xhr.statusText)
