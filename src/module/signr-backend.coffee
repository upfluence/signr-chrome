$ = require('jquery')

API_ENDPOINT = process.env.API_ENDPOINT
APP_ENDPOINT = process.env.APP_ENDPOINT

module.exports =
  isEnabled: (user_infos) ->
    $.ajax
      dataType: 'json',
      url: "#{API_ENDPOINT}/plugin/enable",
      data: user_infos,
      timeout: 5000

  fetchSnippet: (user_infos) ->
    $.ajax
      url: "#{API_ENDPOINT}/plugin/snippet",
      timeout: 5000,
      data:
        email: user_infos.primary
