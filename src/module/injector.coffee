SignatureInjector = (page, menus) ->
  @page = page
  @menus = menus
  return

SignatureInjector.prototype =
  enable: (snippet) ->
    self = @
    @page.onCompose((type, element) ->
      if type == 'compose'
        self.page.injectSnippet(element, snippet)
      if type == 'inline'
        self.page.injectInlineSnippet(element, snippet)
    )
    @page.injectSnippet(element, snippet) for element in @page.composes()

module.exports = SignatureInjector
