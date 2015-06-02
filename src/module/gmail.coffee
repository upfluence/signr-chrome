$ = require('jquery')
# Here, we rely on global Gmail object, defined via content script
gmail = new Gmail($)

extractUserPicture = ->
  item = $('.gbii')
  unless item.empty() then item.css('background-image') else null

extactEmailAliases = ->
  gmail.compose.start_compose()
  $.makeArray($('.J-N.HX').map(-> $(@).attr('value')))

module.exports =
  extractUserInfos: ->
    email = gmail.get.user_email()
    name = null
    gmail.get.loggedin_accounts().forEach (a) ->
      name = a.name if a.email == email
    {
      picture: extractUserPicture(),
      primary: email,
      aliases: extactEmailAliases() || [],
      name: name
    }
