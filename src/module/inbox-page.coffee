$ = require('jquery')

SIGNATURE_ITEM = "<br clear='all'><div><br></div>--<br><div class='signr_signature'></div>"

module.exports =
  startCompose: ->
    $('.y.hC').click()

  composes: ->
    $('.be.k.f')

  onCompose: (callback) ->
    $(document).bind('DOMNodeInserted', (element) ->
      if $(element.target).find('.be.k.f').length
        callback('compose', element)
    )

  emailAliases:(callback) ->
    @startCompose() unless @composes().length
    setTimeout(
      ->
        elt = $('div.kC')[0]
        # Trigger mouseDown event from: dropdown to render alias emails in dom.
        # We should probably gather those datas one time and set in in
        # localStorage
        if elt
          evt = document.createEvent('MouseEvents')
          evt.initEvent('mousedown', true, false)
          elt.dispatchEvent(evt)

        setTimeout(
          ->
            callback(
              $.makeArray($('.do.fy').map(->$(@).html()))
            )
          , 1000
        )
      , 1000
    )

  injectInlineSnippet: (element, snippet) ->
    @injectSnippet(element, snippet)

  injectSnippet: (element, snippet) ->
    if $(element).find('.aR')
                 .find('div[style*="border-color:#deadbe"]')
                 .html() == undefined
      $(element).find('.aR').append(SIGNATURE_ITEM)
      $(element).find('.signr_signature').append(snippet.template)
