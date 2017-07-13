/**
 *  需要引用jQuery 
 **/

function availableBrowser() {
	if ($.browser.msie) {
		if ("6.0" == $.browser.version || "7.0" == $.browser.version) {
			return true;
		}
	}
	return false;
}

function flashPlayer(){
	var hasFlash = false;
	var flashVersion = 0;
	if ($.browser.msie){
		var swf;
		try{
			swf = new ActiveXObject('ShockwaveFlash.ShockwaveFlash');
		} catch (e) {
			swf = null;
		}
		
		if(swf){
			hasFlash = true;
			VSwf = swf.GetVariable("$version");
			flashVersion = parseInt(VSwf.split(" ")[1].split(",")[0]);
			document.write(VSwf);
			document.write("<br/>");
			for(str in VSwf){
				alter(str);
			}
		}
	} else {
		// 其它版本浏览器
		if (navigator.plugins && navigator.plugins.length > 0){
			try{
				swf = navigator.plugins["Shockwave Flash"];
			} catch (e) {
				swf = null;
			}
			if (swf){
				hasFlash = true;
				var words = swf.description.split(" ");
				for (var i = 0; i < words.length; i++){
					if (isNaN(parseInt(words[i])))
						continue;
					flashVersion = parseInt(words[i]);
				}
			}
		}
	}
	return {f:hasFlash, v:flashVersion};
}