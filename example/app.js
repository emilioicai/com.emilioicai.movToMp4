var movtomp4 = require('com.emilioicai.movtomp4');
//[IMPORTANT] At the moment the module requires the file to have a '.mov' extension
var filePath = '/var/mobile/Containers/Data/Application/DDA6SA66D53S/Documents/testMovie.mov';
movtomp4.convert(filePath, function(result){
	console.log(result.filePath);
});