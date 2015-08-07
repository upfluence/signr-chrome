opbeat = require('bower_components/opbeat-js/dist/opbeat.js')

opbeat.Opbeat.config(
  orgId: '9fab231fcf4d4dcd9cd6d8e5ab4a4841',
  appId: 'badf3dcff7'
).install()

module.default = opbeat.Opbeat
