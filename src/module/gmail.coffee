$ = require('jquery')
signr = require('app/module/signr')

SIGNATURE_ITEM = "<div class='gmail_signature'></div>"

# Here, we rely on global Gmail object, injected in dom before
gmail = new Gmail($)

extractUserPicture = ->
  item = $('.gbii')
  unless item.empty() then item.css('background-image') else null

extactEmailAliases = ->
  gmail.compose.start_compose()
  $.makeArray($('.J-N.HX').map(-> $(@).attr('value')))

injectSnippet = (snippet) ->
  gmail.dom.composes().forEach (c) ->
    setTimeout( ->
      if c.dom('body').find('.gmail_signature').length == 0
        c.dom('body').append(SIGNATURE_ITEM)

      if c.dom('body')
          .find('.gmail_signature')
          .find('div[style*="border-color:#deadbe"]').html() == undefined
        c.dom('body').find('.gmail_signature').append(snippet)
    , 500)

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

  enableInjection: (user) ->
    signr.fetchSnippet(user).then((snippet)->
      gmail.observe.on 'compose', -> injectSnippet(snippet.template)
      injectSnippet(snippet.template)
    )
