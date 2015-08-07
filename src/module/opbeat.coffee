require('bower_components/opbeat-js/dist/opbeat.js')

window.Opbeat.config(
  orgId: '9fab231fcf4d4dcd9cd6d8e5ab4a4841',
  appId: 'badf3dcff7'
)

module.exports =
  client: window.Opbeat

  handleXhrError: (xhr) ->
    Opbeat.captureException(xhr.statusText) if xhr.status != 404
