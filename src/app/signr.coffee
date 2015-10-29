$ = require('jquery')

APP_ENDPOINT = "#{process.env.APP_ENDPOINT}/login"

elts = $('.install_signr_plugin')

elts.attr('href', APP_ENDPOINT)
elts.text("LOGIN")
elts.each(-> $(@).replaceWith($(@).clone()))
