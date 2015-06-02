$ = require('jquery')

APP_ENDPOINT = process.env.APP_ENDPOINT

OVERLAY_ITEM = '<div id="signr-overlay"></div>'
OVERLAY_STYLE =
  'position': 'fixed',
  'top': '0',
  'left': '0',
  'width': '100%',
  'height': '100%',
  'background-color': 'rgba(255, 255, 255, 0.8)'
  'z-index': '9999'

CALL_TO_ACTION = "<div id='call-to-action'><p>You are currently not registered to Signr, <a href='#{APP_ENDPOINT}?run=true'>click here</a> to register and use it !</p><p>Then reload your page and enjoy !</p><p>Or you can <a id='signr-optout' href='#'>hide</a> this message</p></div>"
CALL_TO_ACTION_STYLE =
  'text-align': 'center',
  'height': '100%',
  'margin': '10%'

module.exports =
  display: ->
    overlay = $(OVERLAY_ITEM)
    overlay.css(OVERLAY_STYLE)
    callToAction = $(CALL_TO_ACTION)
    callToAction.css(CALL_TO_ACTION_STYLE)
    overlay.append(callToAction)
    overlay.appendTo(document.body)
    $('#signr-optout').click((event)->
      event.preventDefault()
      overlay.remove()
    )
