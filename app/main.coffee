#chrome.app.runtime.onLaunched.addListener () ->
#  chrome.app.window.create('/app/index.html', { top: 10, left: 1100, width: 350, height: 500 })
console.log 'here'
chrome.browserAction.onClicked.addListener((tab) ->
  console.log 'here'
  chrome.tabs.executeScript(tab.id, {code: 'window.scroll(0, 0);'})
)