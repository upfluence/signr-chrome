cto = require('app/module/call_to_action')
inbox = require('app/module/inbox-api')


inbox.on_compose(->
  console.log('HEY HEY HEY')
)

inbox.start_compose()

setTimeout( ->
    console.log("HEY, COMPOSES #{inbox.composes().length}")
  , 1000
)

cto.display()
