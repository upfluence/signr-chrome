$ = require('jquery')
Opbeat = require('app/module/opbeat')

EMAIL_REGEXP = /([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)/gi
NAME_REGEXP = /^ [\w+\s?]{2,2}:? (.*)\s*\(.*\)$/

ACCOUNT_MENU_PATH = 'a[aria-haspopup="true"]:last'
IMAGE_PATH = "#{ACCOUNT_MENU_PATH} > span"

extractBackgroundImage = (element) ->
  if element.length > 0 && element.css('background-image')
    element.css('background-image')[4..-2]
  else
    ''
firstMatch = (matches) ->
  return if matches && matches.length then matches[0] else ''

module.exports =
  email: ->
    # try to get the email from title
    val = firstMatch($('title').first().text().match(EMAIL_REGEXP))

    if val == ''
      #If empty fallback to the account element
      val = firstMatch($(ACCOUNT_MENU_PATH).attr('title').match(EMAIL_REGEXP))

    Opbeat.client.captureException(
      "Failed to extract Email [#{$('title').first().text()}], [#{$(ACCOUNT_MENU_PATH).attr('title')}]"
    ) if val == ''

    val.trim()

  name: ->
    matches = $(ACCOUNT_MENU_PATH).attr('title').match(NAME_REGEXP)
    val = if matches then matches[1] else ''

    Opbeat.client.captureException(
      "Failed to extract Name [#{$(ACCOUNT_MENU_PATH).attr('title')}]"
    ) if val == ''

    val.trim()

  imageUrl: ->
    val = extractBackgroundImage($(IMAGE_PATH))

    Opbeat.client.captureException(
      "Failed to extract Background image [#{$(IMAGE_PATH).css('background-image')}]"
    ) if val == ''

    val
