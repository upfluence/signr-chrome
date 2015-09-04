$ = require('jquery')
opbeat = require('app/module/opbeat')

EMAIL_REGEXP = /([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)/gi
NAME_REGEXP = /^(?:\w+(?:\s|:\s)){2}((?:\S+\s?)+)\s/i

ACCOUNT_MENU_PATH = 'a[aria-haspopup="true"]:last'
IMAGE_PATH = "#{ACCOUNT_MENU_PATH} > span"

extractBackgroundImage = (element) ->
  if element.length > 0 && element.css('background-image')
    element.css('background-image')[4..-2]
  else
    ''
matchAt = (matches, index) ->
  return if matches && matches.length >= index then matches[index] else ''

module.exports =
  email: ->
    # try to get the email from title
    val = matchAt($('title').first().text().match(EMAIL_REGEXP), 0)

    if val == ''
      #If empty fallback to the account element
      val = matchAt($(ACCOUNT_MENU_PATH).attr('title').match(EMAIL_REGEXP), 0)

    opbeat.captureException(
      "Failed to extract Email [#{$('title').first().text()}], [#{$(ACCOUNT_MENU_PATH).attr('title')}]"
    ) if val == ''

    val.trim()

  name: ->
    val = matchAt($(ACCOUNT_MENU_PATH).attr('title').match(NAME_REGEXP), 1)

    opbeat.captureException(
      "Failed to extract Name [#{$(ACCOUNT_MENU_PATH).attr('title')}]"
    ) if val == ''

    val.trim()

  imageUrl: ->
    val = extractBackgroundImage($(IMAGE_PATH))

    opbeat.captureException(
      "Failed to extract Background image [#{$(IMAGE_PATH).css('background-image')}]"
    ) if val == ''

    val
