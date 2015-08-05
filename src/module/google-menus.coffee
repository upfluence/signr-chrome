$ = require('jquery')

module.exports =
  name: ->
    $('.gb_D')[0].firstChild.data

  email: ->
    $('.gb_E')[0].firstChild.data

  imageUrl: ->
    $('.gbii').css('background-image')[5..-3]
