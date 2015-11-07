env = process.env.ENV || 'development'

module.exports =
  development: ->
    env == 'development'

  staging: ->
    env == 'staging'

  production: ->
    env == 'production'
