# Signr chrome plugin

### How to install ?

Easy:
* Just download the latest release [HERE](https://github.com/upfluence/signr-chrome/releases)
* Open chrome extensions page [HERE](chrome://extensions)
* Drag n drop dowloaded file (signr-chrome.crx)

### How to release a new version ?

Still easy :
* make sure you have hub command line tool and crxmake command line utilities setup and available in your `$PATH`.
* Get the .pem file and put it into the ./contrib directory (./contrib/signr-chrome.pem)
* increment version in manifest.json
* create a new release by using `gulp release`
