apiEndpoint = "API_ENDPOINT"
currentSnippet = null
gmail = null

refresh = (f) ->
  if /in/.test(document.readyState) || undefined == Gmail
    setTimeout 'refresh(' + f + ')', 100
  else
    f()


getUserInfo = () ->
  email = gmail.get.user_email()
  name = null
  gmail.get.loggedin_accounts().forEach (a) ->
    if a.email == email
      name = a.name

  picture = $(
    "#gb > div.gb_6b.gb_0c > div.gb_e.gb_0c.gb_r.gb_Zc.gb_pa > div.gb_ba.gb_0c.gb_r > div.gb_p.gb_ea.gb_0c.gb_r > div.gb_fa.gb_s.gb_0c.gb_r > a > span"
  ).css('background-image').slice(4, -1).replace("s64-c/", "")

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
        if c.dom('body').find('.gmail_signature').find('#signr-snippet').html() == undefined
          c.dom('body').find('.gmail_signature').append(snippet)
      , 500)


main = ->
  gmail = new Gmail()

  gmail.observe.on 'compose', (obj) -> appendSignature()

  appendSignature()

refresh main
