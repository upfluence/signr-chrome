apiEndpoint = "API_ENDPOINT"

currentSnippet = null
gmail = null

refresh = (f) ->
  if /in/.test(document.readyState) || undefined == Gmail
    setTimeout 'refresh(' + f + ')', 100
  else
    f()

extractUserPicture = ->
  item = $('.gbii')
  unless item.empty() then item.css('background-image') else null

extactEmailAliases = ->
  gmail.compose.start_compose()
  $.makeArray($('.J-N.HX').map(-> $(@).attr('value')))

extractUserInfos = ->
  email = gmail.get.user_email()
  name = null
  gmail.get.loggedin_accounts().forEach (a) ->
    name = a.name if a.email == email

  {
    picture: extractUserPicture(),
    email: email,
    aliases: extactEmailAliases(),
    name: name
  }

isEnabled = (user_infos, onSuccess, onFailure, onComplete) ->
  $.ajax
    dataType: 'json',
    url: "#{apiEndpoint}/plugin/enable",
    method: 'POST',
    data: JSON.stringify(user_infos),
    success: onSuccess,
    failure: onFailure,
    complete: onComplete


fetchSnippet = (callback) ->
  if currentSnippet
    callback(currentSnippet.template)
  else
    $.ajax
      dataType: 'json',
      url: "#{apiEndpoint}/plugin/snippet",
      success: (data) ->
        currentSnippet = data
        callback(data.template)

appendSignature = ->
  gmail.dom.composes().forEach (c) ->
    fetchSnippet (snippet) ->
      setTimeout( ->
        if c.dom('body')
            .find('.gmail_signature')
            .find('div[style*="border-color:#deabe"]').html() == undefined
          c.dom('body').find('.gmail_signature').append(snippet)
      , 500)

activateSignr = ->
  gmail.observe.on 'compose', -> appendSignature()
  appendSignature()

displayCallToAction= ->
  console.log('HEY CALL TO ACTION')

main = ->
  gmail = new Gmail()
  user_infos = extractUserInfos()
  isEnabled(
    user_infos,
    activateSignr,
    displayCallToAction
  )

refresh main
