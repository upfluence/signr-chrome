cta = require('app/module/call_to_action')
signr = require('app/module/signr')
page = require('app/module/inbox-page')
menus = require('app/module/google-menus')
storage = require('app/module/storage')
app = require('app/module/app')

IdentityProvider = require('app/module/identity')
SignatureInjector = require('app/module/injector')

identity = new IdentityProvider(page, menus, storage)
injector = new SignatureInjector(page, menus)

app.executeWhenReady(-> app.run(identity, injector, signr, cta))
