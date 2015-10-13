should = require('should')
storage = require('app/module/storage')

describe 'storage', ->
  after ->
    localStorage.clear()

  key = 'blah'

  describe 'empty storage', ->
    it 'should not have the value', ->
      storage.has(key).should.be.false()

    it 'should return null value', ->
      should.not.exist(storage.get(key))

  describe 'boolean value', ->
    item = false

    before ->
      storage.set(key, item)

    it 'should store and conserve the type', ->
      storage.get(key).should.be.false()

  describe 'string value', ->
    item = "DOH"

    before ->
      storage.set(key, item)

    it 'should store and conserve the type', ->
      storage.get(key).should.equal(item)

  describe 'object storage', ->
    item =
      foo: 'bar'
      buz: true

    before ->
      storage.set(key, item)

    it 'should prefix the used key', ->
      JSON.parse(
        localStorage.getItem('signr-storage.blah')
      ).should.deepEqual(item)

    it 'should have the value', ->
      storage.has(key).should.be.true()

    it 'should read the value as object', ->
      storage.get(key).should.be.deepEqual(item)
