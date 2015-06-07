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
    $(window.document).bind('DOMNodeInserted', (element) ->
      if $(element.target).find('.be.k.f').length
        callback(element)
    )

  emailAliases:(callback) ->
    @startCompose() unless @composes().length
    setTimeout(->
        callback([])
      ,100
    )
