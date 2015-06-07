api = require('app/module/inbox-api')
$ = require('jquery')

module.exports =
  extractUserInfos: ->
    $.Deferred((defer) ->
      api.emailAliases((aliases)->
        defer.resolve(
          picture: api.imageUrl(),
          primary: api.email(),
          name: api.name()
          aliases: aliases
        )
      )
    ).promise()
