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
      email = self.menus.email()

      if self.storage.has(email)
        defer.resolve(self.storage.get(email))
      else
        self.page.emailAliases((aliases) ->
          user =
            picture: self.menus.imageUrl(),
            primary: email,
            name: self.menus.name(),
            aliases: aliases
          self.storage.set(email, user)
          defer.resolve(user)
        )
      ).promise()

module.exports = IdentityProvider
