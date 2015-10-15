page = require('app/module/gmail-page')
menus = require('app/module/google-menus')
storage = require('app/module/storage')

api = require('app/module/signr')
app = require('app/module/app')

CallToActionController = require('app/module/call-to-action')
IdentityProvider = require('app/module/identity')
SignatureInjector = require('app/module/injector')

identity = new IdentityProvider(page, menus, storage)
injector = new SignatureInjector(page, menus)
cta = new CallToActionController(storage)

app.executeWhenReady(-> app.run(identity, injector, api, cta))
