chrome.app.runtime.onLaunched.addListener () ->
  chrome.app.window.create('/app/index.html', { top: 10, left: 1100, width: 350, height: 350   })
