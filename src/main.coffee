apiEndpoint = "API_ENDPOINT"
currentSnippet = null
gmail = null

refresh = (f) ->
  if /in/.test(document.readyState) || undefined == Gmail
    setTimeout 'refresh(' + f + ')', 100
  else
    f()

fetchSnippet = (callback) ->
  console.log 'fetching ..'
  if currentSnippet
    callback(currentSnippet.template)
  else
    $.getJSON(
     "#{apiEndpoint}/snippet?email=#{encodeURIComponent(gmail.get.user_email())}",
      (res) ->
        currentSnippet = res
        callback(currentSnippet.template)
    )

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
