apiEndpoint = "API_ENDPOINT"
currentSnippet = null
gmail = null

refresh = (f) ->
  if /in/.test(document.readyState) || undefined == Gmail
    setTimeout 'refresh(' + f + ')', 100
  else
    f()

getUserPicture = ->
  item = $('.gbii')
  unless item.empty() then item.css('background-image') else ''

getUserInfo = () ->
  email = gmail.get.user_email()
  name = null
  gmail.get.loggedin_accounts().forEach (a) ->
    if a.email == email
      name = a.name
  picture = getUserPicture()
  {
    picture: picture,
    email: email,
    name: name
  }

fetchSnippet = (callback) ->
  console.log 'fetching ..'
  if currentSnippet
    callback(currentSnippet.template)
  else
    $.ajax
      dataType: 'json',
      url: "#{apiEndpoint}/snippet",
      data: getUserInfo()
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


main = ->
  gmail = new Gmail()

  gmail.observe.on 'compose', (obj) -> appendSignature()

  appendSignature()

refresh main
