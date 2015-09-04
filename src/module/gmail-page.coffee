$ = require('jquery')

SIGNATURE_ITEM = "<br clear='all'><div><br></div>--<br><div class='gmail_signature'></div>"

module.exports =
  startCompose: ->
    elt = $('.T-I.J-J5-Ji.T-I-KE.L3')[0]
    if elt
      down = document.createEvent('MouseEvents')
      down.initEvent( 'mousedown', true, false )
      elt.dispatchEvent(down)
      up = document.createEvent('MouseEvents')
      up.initEvent( 'mouseup', true, false )
      elt.dispatchEvent(up)

  composes: ->
    $('div.M9')

  onCompose: (callback) ->
    $(window.document).bind('DOMNodeInserted', (event) ->
      if $(event.target).find('.AD').length ||
         $(event.target).find('.HX').length
        callback(event)
    )

  emailAliases:(callback) ->
    @startCompose() unless @composes().length
    setTimeout(->
        callback(
          $.makeArray($('.J-N.HX').map(-> $(@).attr('value')))
        )
      , 500
    )

  injectSnippet: (element, snippet) ->
    setTimeout(->
        if $(element).find('.gmail_signature').length == 0 &&
           $(element).find('div[style*="border-color:#deadbe"]').length == 0
          $(element).find('.Am').append(SIGNATURE_ITEM)

        if $(element)
            .find('.gmail_signature')
            .find('div[style*="border-color:#deadbe"]').html() == undefined
          $(element).find('.gmail_signature').first().append(snippet.template)
      , 1000
    )

