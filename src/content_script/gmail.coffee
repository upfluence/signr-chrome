signr = require('app/module/signr-backend')

user_infos = email: 'toto@tata.com'

promise = signr.isEnabled(user_infos)
debugger
