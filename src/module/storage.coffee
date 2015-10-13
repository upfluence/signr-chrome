ROOT = "signr-storage"

_formatKey = (key) ->
  "#{ROOT}.#{key}"

module.exports =
  set: (key, value) ->
    localStorage.setItem(_formatKey(key), JSON.stringify(value))

  get: (key) ->
    JSON.parse(localStorage.getItem(_formatKey(key)))

  has: (key) ->
    localStorage.getItem(_formatKey(key)) != null
