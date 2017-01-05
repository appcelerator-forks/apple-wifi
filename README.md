# apple-wifi
A Titanium module. You can use it to get the state of the wifi adapter on an iOS device.

Usage:

```
var appleWifi = require("com.restado.appleWifi");
var wifi_status = appleWifi.isWIFIEnabled(); //0: off, 1: on, 2: unknown. the last only occurs with the iPhone 4S.
```
