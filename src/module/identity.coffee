$ = require('jquery')

class IdentityProvider
  constructor: (page, menus, storage) ->
    @page = page
    @menus = menus
    @storage = storage

  fetchUserInfos: ->
    self = @
    $.Deferred((defer) ->
      email = self.menus.email()
      defer.reject() if email == ''

      picture = self.menus.imageUrl()
      name = self.menus.name()

      if self.storage.has(email)
        user = self.storage.get(email)
        user.picture = picture unless picture == ''
        user.name = name unless name == ''
        self.storage.set(email, user)
        defer.resolve(user)
      else
        self.page.emailAliases((aliases) ->
          user =
            picture: picture,
            primary: email,
            name: name,
            aliases: aliases
          self.storage.set(email, user)
          defer.resolve(user)
        )
      ).promise()

module.exports = IdentityProvider
