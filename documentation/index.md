# com.emilioicai.movToMp4
## What is this?
This is an iOS module for titnamium to convert mov files into MP4.

Sometimes we need to develop applications both for android and iOS that uses the videos captured from the devices.By default iOS saves the video in .mov format which can not be played on the android devices.To make the iOS videos compatible for all devices(android and iOS) we use a common video format and that is .mp4. Now we can achieve this by using AVFoundation framework.

##USAGE
First you need to unzip the module zipfile into the `modules` folder in your project

Then you need to include the module in your tiapp.xml:
`<module platform="iphone" version="1.0.1">com.emilioicai.movtomp4</module>`

Then you are ready to use it:

```javascript
var movtomp4 = require('com.emilioicai.movtomp4');
//[IMPORTANT] At the moment the module requires the file to have a '.mov' extension
var filePath = '/var/mobile/Containers/Data/Application/DDA6SA66D53S/Documents/testMovie.mov';
movtomp4.convert(filePath, function(result){
	console.log(result.filePath);
});

```

###convert(filePath, callBack)
triggers the native conversion of the file in `filePath` into an MP4 file which will be saved and which location will be passed to the callBack provided. [IMPORTANT] at the moment the input file should contain the '.mov' extension for the native conversor to recognize the file as a Quicktime file.

