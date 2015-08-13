module.exports=
  onInstalled: (callback) ->
    chrome.runtime.onInstalled.addListener((detail) ->
      callback(detail) if  detail.reason == "install"
    )

  openTab: (url) ->
    chrome.tabs.create({ url: url })
