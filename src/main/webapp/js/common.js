function realHeight(obj){
	var clone = obj.clone();
	$('body').append(clone);
	var height = clone.outerHeight();
	clone.remove();
	return height;
}


/**
 * 원하는 커스텀 포멧터를 정의할 수 있습니다.
 * 공통 js 파일에 작성하시면 한 번 정의로 여러번 사용하실 수 있습니다.
 */
Object.extend(AXGrid.prototype.formatter, {
    "gradeType": function (formatter, item, itemIndex, value, key, CH, CHidx) {
        if (!value) return '';
        var str='매우좋음';
			if(value=='3'){
				str='매우좋음';
			}else if(value=='2'){
				str='좋음';
			}else if(value=='1'){
				str='나쁨';
			}else if(value=='0'){
				str='매우나쁨';
			}
        return str;
    },
    "gradeType1": function (formatter, item, itemIndex, value, key, CH, CHidx) {
        if (!value) return '';
        var str='특상';
        
		if(value=='3'){
			str='특상';
		}else if(value=='2'){
			str='상';
		}else if(value=='1'){
			str='중';
		}else if(value=='0'){
			str='하';
		}
        return str;
    },
    "definitionType": function (formatter, item, itemIndex, value, key, CH, CHidx) {
        if (!value) return '';
        var str='매우선명';
			if(value=='3'){
				str='매우선명';
			}else if(value=='2'){
				str='선명';
			}else if(value=='1'){
				str='탁함';
			}else if(value=='0'){
				str='매우탁함';
			}
        return str;
    },
    "ynType": function (formatter, item, itemIndex, value, key, CH, CHidx) {
        if (!value) return '';
        var str='무';
		
        if(value=='Y'){
			str='유';
		}else if(value=='N'){
			str='무';
		}
        return str;
    },
    "flowerColor": function (formatter, item, itemIndex, value, key, CH, CHidx) {
        if (!value) return '';
        var str='그외';
        
        switch(value){
        case 'red' :
	    	str='빨강';
	    	break;
	    case 'blue' :
			str='파랑';
			break;
	    case 'yellow' :
			str='노랑';
			break;
	    case 'white' :
			str='하얀';
			break;
	    case 'pink' :
			str='분홍';
			break;
	    case 'orange' :
			str='주황';
			break;
	    case 'puple' :
			str='보라';
			break;
	    case 'etc' :
			str='그외';
			break;			
		default : 
			str ='그외';
			break;
        }
        return str;
    }
});