var count=10;

var counter=setTimeout(notify, 1000); //1000 will  run it every 1 second

function notify() {
  var havePermission = window.webkitNotifications.checkPermission();
  if (havePermission == 0) {
    // 0 is PERMISSION_ALLOWED
    var notification = window.webkitNotifications.createNotification(
      'http://i.stack.imgur.com/dmHl0.png',
      'Chrome notification!',
    'Here is the notification text'
    );
    
    notification.onload = function () {
      window.open("http://stackoverflow.com/a/13328397/1269037");
      notification.close();
    }
    notification.show();
  } else {
      window.webkitNotifications.requestPermission();
  }
}  