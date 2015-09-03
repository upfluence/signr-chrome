$ = require 'jquery'
google_menus = require 'app/module/google-menus'

describe 'google-menus', ->
  describe '#email', ->
    context 'with a title carrying email in dom', ->
      before ->
        $('title').first().text('Boîte de réception (683) - foo@bar.com - Gmail')

      after ->
        $('title').first().text('Mocha Tests runner')

      it 'should extract the email address from title', ->
        google_menus.email().should.be.exactly('foo@bar.com')

    context 'without a title', ->
      before ->
        $('#mocha').append(
          '<a id=target aria-haspopup="true" title="foo@bar.com">Hey</a>'
        )

      after ->
        $('#target').remove()

      it 'should extract email from google menubar', ->
        google_menus.email().should.be.exactly('foo@bar.com')
