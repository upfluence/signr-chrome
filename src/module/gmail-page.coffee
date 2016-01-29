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
      if event.target.className.split(/\s/).indexOf('An') >= 0
        setTimeout(->
            match = $(event.target).closest('div.M9')
            return unless match
            callback(
              if $(match).closest('td.Bu').length > 0 then 'inline' else 'compose',
              match
            )
          , 100
        )
    )

  emailAliases: (callback) ->
    @startCompose() unless @composes().length
    setTimeout(->
        callback(
          $.makeArray($('.J-N.HX').map(-> $(@).attr('value')))
        )
      , 500
    )

  injectInlineSnippet: (element, snippet) ->
    t = element.find('.ajR')
    if t
      t.click()
      @injectSnippet(element, snippet)

  injectSnippet: (element, snippet) ->
    if $(element).find('.gmail_signature').length == 0 &&
       $(element).find('div[style*="border-color:#deadbe"]').length == 0 &&
       $(element).find('div[style*="border-color:rgb(222,173,190)"]').length == 0
      $(element).find('.Am').append(SIGNATURE_ITEM)

    sig = $(element).find('.gmail_signature')
    if sig.find('div[style*="border-color:#deadbe"]').html() == undefined &&
       sig.find('div[style*="border-color:rgb(222,173,190)"]').html() == undefined
      $(element).find('.gmail_signature').first().append(snippet.template)
