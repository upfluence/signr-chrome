var g = document.createElement('script');
g.src = chrome.extension.getURL('bower_components/gmail.js/src/gmail.js');
(document.head || document.documentElement).appendChild(g);

var s = document.createElement('script');
s.src = chrome.extension.getURL('app/signr-gmail.js');
(document.head || document.documentElement).appendChild(s);

