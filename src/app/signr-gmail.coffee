cta = require('app/module/call_to_action')
page = require('app/module/gmail-page')
menus = require('app/module/google-menus')
storage = require('app/module/storage')

api = require('app/module/signr')
app = require('app/module/app')

IdentityProvider = require('app/module/identity')
SignatureInjector = require('app/module/injector')

identity = new IdentityProvider(page, menus, storage)
injector = new SignatureInjector(page, menus)

app.execute_when_ready(-> app.run(identity, injector, api, cta))
