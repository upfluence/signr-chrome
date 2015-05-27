apiEndpoint = "API_ENDPOINT"

OVERLAY_ITEM = '<div id="signr-overlay"></div>'
OVERLAY_STYLE =
  'position': 'fixed',
  'top': '0',
  'left': '0',
  'width': '100%',
  'height': '100%',
  'background-color': 'rgba(255, 255, 255, 0.8)'
  'z-index': '9999'

CALL_TO_ACTION = "<div id='call-to-action'><p>You are currently not registered to signr, <a href='#{apiEndpoint}?run=true'>click here</a> to register and use Signr !</p><p>Then reload your page and enjoy !</p></div>"
CALL_TO_ACTION_STYLE =
  'text-align': 'center',
  'height': '100%',
  'margin-left': '10%',
  'margin-right': '10%',
  'margin-top': '25%'

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
    primary: email,
    aliases: extactEmailAliases(),
    name: name
  }

isEnabled = (user_infos, onSuccess, onError) ->
  $.ajax
    dataType: 'json',
    url: "#{apiEndpoint}/plugin/enable",
    method: 'POST',
    data: user_infos,
    timemout: 500,
    success: onSuccess,
    error: onError


fetchSnippet = (callback) ->
  if currentSnippet
    callback(currentSnippet.template)
  else
    $.ajax
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
  overlay = $(OVERLAY_ITEM)
  overlay.css(OVERLAY_STYLE)
  callToAction = $(CALL_TO_ACTION)
  callToAction.css(CALL_TO_ACTION_STYLE)
  overlay.append(callToAction)
  overlay.appendTo(document.body)

main = ->
  gmail = new Gmail()
  user_infos = extractUserInfos()
  isEnabled(
    user_infos,
    activateSignr,
    displayCallToAction
  )

refresh main
