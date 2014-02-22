chrome.app.runtime.onLaunched.addListener () ->
  chrome.app.window.create('/app/index.html', { top:10, width: 500, height: 309 })
