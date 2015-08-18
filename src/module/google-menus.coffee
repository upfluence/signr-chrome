$ = require('jquery')
Opbeat = require('app/module/opbeat')

EMAIL_REGEXP = /([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)/gi
ACCOUNT_MENU_PATH = 'a[aria-haspopup="true"]:last'
IMAGE_PATH = "#{ACCOUNT_MENU_PATH} > span"

extractEmail = (value) ->
  value.match(EMAIL_REGEXP)[0] || ''

extractName = (value) ->
  value

extractBackgroundImage = (element) ->
  if element.length > 0 && element.css('background-image')
    element.css('background-image')[4..-2]
  else
    ''

module.exports =
  email: ->
    # try to get the email from title
    val = extractEmail($('title').first().text())
    if val == ''
      #If empty fallback to the account element
      val = extractEmail($(ACCOUNT_MENU_PATH).attr('title'))

    Opbeat.client.captureException(
      "Failed to extract Email [#{$('title').first().text()}], [#{$(ACCOUNT_MENU_PATH).attr('title')}]"
    ) if val == ''

    val

  name: ->
    val = extractName($(ACCOUNT_MENU_PATH).attr('title'))

    Opbeat.client.captureException(
      "Failed to extract Name [#{$(ACCOUNT_MENU_PATH).attr('title')}]"
    ) if val == ''

    val

  imageUrl: ->
    val = extractBackgroundImage($(IMAGE_PATH))
    Opbeat.client.captureException(
      "Failed to extract Background image [#{$(IMAGE_PATH).css('background-image')}]"
    ) if val == ''
    val
