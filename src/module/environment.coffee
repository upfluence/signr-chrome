env = process.env.ENV || 'development'

module.exports =
  development: ->
    env == 'development'

  production: ->
    env == 'production'
