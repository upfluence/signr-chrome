$ = require('jquery')

safeExtractText = (element) ->
  if element.length > 0 then element.text() else ""

safeExtractBackgroundImage = (element) ->
  if element.length > 0 && element.css('background-image')
    element.css('background-image')[4..-2]
  else
    ""

module.exports =
  name: ->
    safeExtractText($('.gb_Ca'))

  email: ->
    safeExtractText($('.gb_Da'))

  imageUrl: ->
    safeExtractBackgroundImage($('.gbii'))
