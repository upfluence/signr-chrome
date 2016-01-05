$ = require('jquery')
opbeat = require('app/module/opbeat')

EMAIL_REGEXP = /([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)/gi
NAME_REGEXP = /^(?:\w+(?:\s|:\s)){2}((?:[A-Za-z0-9_\u00C0-\u017F]+\s?)+)\s/i

ACCOUNT_MENU_PATH = 'a[aria-expanded]:last'
IMAGE_PATH = "#{ACCOUNT_MENU_PATH} > span"

extractBackgroundImage = (element) ->
  if element.length > 0 && element.css('background-image')
    element.css('background-image')[5..-3]
  else
    ''
matchAt = (matches, index) ->
  return if matches && matches.length >= index then matches[index] else ''

module.exports =
  email: ->
    # try to get the email from title
    try
      val = matchAt($('title').first().text().match(EMAIL_REGEXP), 0)
    catch e
      opbeat.captureException(
        "Failed to extract Email: exception: #{e}"
      )
      val = ''

    if val == ''
      #If empty fallback to the account element
      try
        val = matchAt($(ACCOUNT_MENU_PATH).attr('title').match(EMAIL_REGEXP), 0)
      catch e
        opbeat.captureException(
          "Failed to extract Email: exception: #{e}"
        )
        return ''

    opbeat.captureException(
      "Failed to extract Email [#{$('title').first().text()}], [#{$(ACCOUNT_MENU_PATH).attr('title')}]"
    ) if val == ''
    val.trim()

  name: ->
    try
      val = matchAt($(ACCOUNT_MENU_PATH).attr('title').match(NAME_REGEXP), 1)
    catch e
      opbeat.captureException(
        "Failed to extract Name: exception: #{e}"
      )
      return ''

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
