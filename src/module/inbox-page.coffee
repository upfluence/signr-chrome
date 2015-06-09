$ = require('jquery')

module.exports =
  name: ->
    $('.gb_D')[0].firstChild.data

  email: ->
    $('.gb_E')[0].firstChild.data

  imageUrl: ->
    $('.gbii').css('background-image')

  startCompose: ->
    $('.y.hC').click()

  composes: ->
    $('.be.k.f')

  onCompose: (callback) ->
    $(document).bind('DOMNodeInserted', (element) ->
      if $(element.target).find('.be.k.f').length
        callback(element)
    )

  emailAliases:(callback) ->
    @startCompose() unless @composes().length
    setTimeout(->
        elt = $('div.kC')[0]

        # Trigger mouseDown event from: dropdown to render alias emails in dom.
        # We should probably gather those datas one time and set in in
        # localStorage
        if elt
          evt = document.createEvent('MouseEvents')
          evt.initEvent('mousedown', true, false)
          elt.dispatchEvent(evt)

        callback(
          $.makeArray($('.do.fy').map(->$(@).html()))
        )
      , 100
    )

  injectSnippet: (element, snippet) ->
    if $(element).find('.aR')
                 .find('div[style*="border-color:#deadbe"]')
                 .html() == undefined
      $(element).find('.aR').append(snippet.template)
