$ = require('jquery')

NAME_TAGS  = ['.gb_Ca', '.gb_D']
EMAIL_TAGS = ['.gb_Da', '.gb_E']
AVATAR_TAGS = ['.gbii']

extractText = (element) ->
  if element.length > 0 then element.text() else ""

extractBackgroundImage = (element) ->
  if element.length > 0 && element.css('background-image')
    element.css('background-image')[4..-2]
  else
    ""

extractValue = (tags, extractCallback) ->
  vals = tags.map((tag) -> extractCallback($(tag)))
              .filter((value) -> value != "")
  if vals.length > 0 then vals[0] else ''

module.exports =
  name: ->
    extractValue(NAME_TAGS, extractText)

  email: ->
    extractValue(EMAIL_TAGS, extractText)

  imageUrl: ->
    extractValue(AVATAR_TAGS, extractBackgroundImage)
