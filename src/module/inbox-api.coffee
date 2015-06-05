$ = require('jquery')

module.exports =
  name: ->
    $('.gb_D')[0].firstChild.data

  email: ->
    $('.gb_E')[0].firstChild.data

  image_url: ->
    $('.gbii').css('background-image')

  start_compose: ->
    $('.y.hC').click()

  on_compose: (callback) ->
    $(window.document).bind('DOMNodeInserted', (element) ->
      debugger
    )

  aliases: ->
    $.Deferred((defer)->
       
    ).promise()
