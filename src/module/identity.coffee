$ = require('jquery')

IdentityProvider = (page, menus, storage) ->
  @page = page
  @menus = menus
  @storage = storage
  return

IdentityProvider.prototype =
  fetchUserInfos: ->
    self = @
    $.Deferred((defer) ->
      self.page.emailAliases((aliases) ->
        defer.resolve(
          picture: self.menus.imageUrl(),
          primary: self.menus.email(),
          name: self.menus.name()
          aliases: aliases
        )
      )
    ).promise()


module.exports = IdentityProvider
