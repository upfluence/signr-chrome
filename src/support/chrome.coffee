CSP_REGEXP = /content-security-policy|^x-webkit-csp(-report-only)?$/i

IFRAME_HOSTS = [
  'https://*.amazonaws.com/'
]

module.exports=
  onInstalled: (callback) ->
    chrome.runtime.onInstalled.addListener((detail) ->
      callback(detail) if  detail.reason == "install"
    )

  openTab: (url) ->
    chrome.tabs.create({ url: url })

  extendCSP: ->
    chrome.webRequest.onHeadersReceived.addListener((details) ->
      {
        responseHeaders: details.responseHeaders.map((header) ->
          return header unless CSP_REGEXP.test(header.name)
          header.value = header.value.replace(
            'frame-src',
            "frame-src #{IFRAME_HOSTS}"
          )
          header
        )
      }
    , {
      urls: ['https://mail.google.com/*', 'https://inbox.google.com/*']
      types: ['main_frame']
    }, ['blocking', 'responseHeaders'])
