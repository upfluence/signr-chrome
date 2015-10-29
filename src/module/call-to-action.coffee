$ = require('jquery')

OVERLAY_ITEM = '<div id="signr-overlay"></div>'
OVERLAY_STYLE =
  'position': 'fixed',
  'top': '0',
  'left': '0',
  'width': '100%',
  'height': '100%',
  'color': '#ffffff',
  'background-color': 'rgba(0, 0, 0, 0.8)'
  'z-index': '9999'

FRAME = "<iframe id='signr-iframe' frameBorder='0'\
                 src='#{process.env.ASSETS_CDN}/plugin/plugin.html'></iframe>"
FRAME_STYLE =
  'text-align': 'center',
  'height': '70%',
  'width': '100%',
  'overflow': 'hidden'

OPTOUT = '<div><a id="signr-hide" href="#">Hide</a> this message once, or <a id="signr-remove" href="#">never</a> show it again.</p></div>'
OPTOUT_STYLE =
  'text-align': 'center',

class CallToActionController
  constructor: (storage) ->
    @storage = storage

  display: (user) ->
    return if @storage.has("#{user.primary}.disabled")

    self = @
    overlay = $(OVERLAY_ITEM)
    overlay.css(OVERLAY_STYLE)
    frame = $(FRAME)
    frame.css(FRAME_STYLE)
    optout = $(OPTOUT)
    optout.css(OPTOUT_STYLE)
    overlay.append(frame)
    overlay.append(optout)
    overlay.appendTo(document.body)

    $('#signr-hide').click((event) ->
      event.preventDefault()
      overlay.remove()
    )

    $('#signr-remove').click((event) ->
      event.preventDefault()
      self.storage.set("#{user.primary}.disabled", true)
      overlay.remove()
    )

module.exports = CallToActionController
