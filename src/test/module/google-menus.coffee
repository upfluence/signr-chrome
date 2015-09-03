$ = require 'jquery'
google_menus = require 'app/module/google-menus'

describe 'google-menus', ->
  describe '#name', ->
    context 'with an english account', ->
      before ->
        $('#mocha').append(
          '<a id=target aria-haspopup="true" title="Google Account: John Doe (jdoe@gmail.com)">Hey</a>'
        )
        $('title').first().text('Boîte de réception (683) - foo@bar.com - Gmail')

      after ->
        $('#target').remove()

      it 'should extract name from title', ->
        google_menus.name().should.be.exactly('John Doe')

    context 'with an french account', ->
      before ->
        $('#mocha').append(
          '<a id=target aria-haspopup="true" title="Google Account John Doe (jdoe@gmail.com)">Hey</a>'
        )
        $('title').first().text('Boîte de réception (683) - foo@bar.com - Gmail')

      after ->
        $('#target').remove()

      it 'should extract name from title', ->
        google_menus.name().should.be.exactly('John Doe')

    context 'with an undefined name', ->
      before ->
        $('#mocha').append(
          '<a id=target aria-haspopup="true" title="Google Account jdoe@gmail.com">Hey</a>'
        )

      after ->
        $('#target').remove()

      it 'should not extract name from title', ->
        google_menus.name().should.be.exactly('')

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