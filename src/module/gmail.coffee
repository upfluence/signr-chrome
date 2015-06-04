$ = require('jquery')
signr = require('app/module/signr')

SIGNATURE_ITEM = "<div class='gmail_signature'></div>"

# Here, we rely on global Gmail object, injected in dom before
gmail = new Gmail($)

extractUserPicture = ->
  item = $('.gbii')
  unless item.empty() then item.css('background-image') else null

extactEmailAliases = (callback) ->
  gmail.compose.start_compose() unless gmail.dom.composes().length
  setTimeout(->
    callback(
      $.makeArray($('.J-N.HX').map(-> $(@).attr('value')))
    )
  , 100)

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
    $.Deferred((defer) ->
      extactEmailAliases((aliases) ->
        email = gmail.get.user_email()
        name = null
        gmail.get.loggedin_accounts().forEach (a) ->
          name = a.name if a.email == email
        defer.resolve({
          picture: extractUserPicture(),
          primary: email,
          aliases: aliases,
          name: name
        })
      )
    ).promise()


  enableInjection: (user) ->
    signr.fetchSnippet(user).then((snippet)->
      gmail.observe.on 'compose', -> injectSnippet(snippet.template)
      injectSnippet(snippet.template)
    )
