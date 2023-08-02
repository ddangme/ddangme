const weather_title = document.getElementById("weather_title");

const current_search = document.getElementById("current_search");

const depth1 = document.getElementById("depth1");
const depth2 = document.getElementById("depth2");
const depth3 = document.getElementById("depth3");

// [현재 위치 탐색] 버튼을 클릭한 경우
current_search.addEventListener('click', ()=> {
	if (document.getElementById('map').children[1] != undefined) {
		document.getElementById('map').children[1].remove();
	}
	navigator.geolocation.getCurrentPosition(success,fail);
});

// 현재 위치 가져오기 성공한 경우
	function success(pos){
	document.getElementById("tool").innerText = '';
	var currentPos = new kakao.maps.LatLng(pos.coords.latitude,pos.coords.longitude);
	var container = document.getElementById('map');
	var marker = new kakao.maps.Marker({
		position: currentPos
	});
	
	var options = {
		center: new kakao.maps.LatLng(currentPos.Ma, currentPos.La),
		level: 6, // 지도의 확대 크기
		marker: marker,
		scrollwheel: false,
		disableDoubleClick: true,
		disableDoubleClickZoom: true
	};
	
 	var map = new kakao.maps.StaticMap(container, options);
 	
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 날씨 데이터 출력
	weatherFn(parseInt(currentPos.Ma), parseInt(currentPos.La));

	searchAddrFromCoords(new kakao.maps.LatLng(currentPos.Ma, currentPos.La), displayCenterInfo);
	function displayCenterInfo(result, status) {
		if (status === kakao.maps.services.Status.OK) {
		    for(var i = 0; i < result.length; i++) {
		    	// 행정동의 region_type 값은 'H' 이므로
		        if (result[i].region_type === 'H') {
			    	console.log("법정 행정동 주소 정보 : ", result[i].address_name);
			    	weather_title.innerText = result[i].address_name + ' 날씨';
		            break;
		        }
		    }
		}    
	}

	function searchAddrFromCoords(coords, callback) {
	    // 좌표로 행정동 주소 정보를 요청합니다
	    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
	}
	
};



// 현재 위치 가져오기 실패한 경우
function fail(pos){
	alert('위치 정보를 가져오는데 실패했습니다.\n검색하여 현재 위치를 선택해 주세요.');
	var container = document.getElementById('map');
	container.remove()
};


// [현재 위치] 탭 클릭
document.getElementById("btnradio1").addEventListener('click', ()=> {
	// 카카오 맵 영역 안내 문구 노출
	document.getElementById("tool").innerText = '현재 위치 탐색 버튼을 클릭해 주세요!';
	// 카카오 맵에 이미 노출되고 있는 데이터가 있다면 삭제
	if (document.getElementById('map').children[1] != undefined) {
		document.getElementById('map').children[1].remove();
	}
	// [현재 위치 탐색] 버튼 노출
	current_search.style = "";
	// 시/도, 구/군, 읍/면/동 영역 미노출
	document.getElementById("address_area").style = "display: none;";
	depth1.children[0].selected='selected'
	depth2.innerHTML = '<option>구/군</option>';
	depth3.innerHTML = '<option>읍/면/동</option>';
});

// [위치 선택] 탭 클릭
document.getElementById("btnradio2").addEventListener('click', ()=> {
	// 카카오 맵 영역 안내 문구 노출
	document.getElementById("tool").innerText = '시/도, 구/군, 읍/면/동을 선택해 주세요!';
	// 카카오 맵에 이미 노출되고 있는 데이터가 있다면 삭제
	if (document.getElementById('map').children[1] != undefined) {
		document.getElementById('map').children[1].remove();
	}
	// [현재 위치 탐색] 버튼 미노출
	current_search.style = "display:none";
	// 시/도, 구/군, 읍/면/동 영역 노출
	document.getElementById("address_area").style = "";
});


// depth1 변경 시 depth2 리스트 출력 및 depth3 리스트 초기화
depth1.addEventListener('change', () => {
	if (depth1.value != '시/도') {
		var url = "weather/depth2";
		var param = "depth1=" + encodeURIComponent(depth1.value);
		sendRequest(url, param, depth2RFn, "POST");
	}
	depth2.innerHTML = '<option>구/군</option>';
	depth3.innerHTML = '<option>읍/면/동</option>';
});


function depth2RFn() {
	if(xhr.readyState == 4 && xhr.status == 200) {
		const list = xhr.response.split(',')
		for (let i in list) {
			const re = /[^0-9ㄱ-힣]/g;
			const temp = document.createElement("option");
			temp.value = list[i].replace(re, "");
			temp.innerHTML = list[i].replace(re, "");
			depth2.append(temp);
		}
	}
}

depth2.addEventListener('change', () => {
	if (depth2.value != '구/군') {
		var url = "weather/depth3";
		var param = "depth1=" + encodeURIComponent(depth1.value) + "&depth2=" + encodeURIComponent(depth2.value);
		sendRequest(url, param, depth3RFn, "POST");
	}
	depth3.innerHTML = '<option>읍/면/동</option>';
});

function depth3RFn() {
	if(xhr.readyState == 4 && xhr.status == 200) {
		const list = xhr.response.split(',')
		for (let i in list) {
			const re = /[^0-9ㄱ-힣]/g;
			const temp = document.createElement("option");
			temp.value = list[i].replace(re, "");
			temp.innerHTML = list[i].replace(re, "");
			depth3.append(temp);
		}
	}
}

depth3.addEventListener('change', () => {
	document.getElementById("tool").innerText = '';
	var geocoder = new kakao.maps.services.Geocoder();
	var addr = depth1.value + depth2.value + depth3.value;
	
	// 입력된 시/도, 구/군, 읍/면/동 데이터로 좌표 검색하여 맵의 센터로 지정
	geocoder.addressSearch(addr, function(result, status) {
	     if (status === kakao.maps.services.Status.OK) {
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			var container = document.getElementById('map');
			if (container.children[1] != undefined) {
				container.children[1].remove();
			}
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
			var options = {
				center: coords,
				level: 6, // 지도의 확대 크기
				marker: marker,
				scrollwheel: false,
				disableDoubleClick: true,
				disableDoubleClickZoom: true
			};
		 	var map = new kakao.maps.StaticMap(container, options);
		 	weatherFn(parseInt(coords.Ma), parseInt(coords.La));
	    } 
	}); 
})

// 현재 선택된 주소에 맞는 날씨 데이터 출력
let data = [];
function weatherFn(La, Ma) {
	var timeList = {
			'00' : '2300',
			'01' : '2300',
			'02' : '0200',
			'03' : '0200',
			'04' : '0200',
			'05' : '0500',
			'06' : '0500',
			'07' : '0500',
			'08' : '0800',
			'09' : '0800',
			'10' : '0800',
			'11' : '1100',
			'12' : '1100',
			'13' : '1100',
			'14' : '1400',
			'15' : '1400',
			'16' : '1400',
			'17' : '1700',
			'18' : '1700',
			'19' : '1700',
			'20' : '2000',
			'21' : '2000',
			'22' : '2000',
			'23' : '2300',
	}
	var now = new Date();
	var year = now.getFullYear();
	let month = now.getMonth() + 1;
	if (month <= 9) {
		month = '0' + month.toString();
	}
	var date = now.getDate();
	var nowDate = year.toString() + month.toString() + date.toString();	
	var nowTime = timeList[now.getHours().toString()];
 	const weather_data = document.getElementById("weather_data");
	var xhr = new XMLHttpRequest();
	// 단기 예보 조회
	var url = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst';
	var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'r5iJNMH%2FbMytmlJ%2F7wVekRDd%2Bf0yTAXAiKTHjCKKPPMP7JMO2f%2B3fWg5cSoVImrLYAGmLoW3LvvZn9n6zxn1IQ%3D%3D';
	queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('10');
	queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('1000');
	queryParams += '&' + encodeURIComponent('dataType') + '=' + encodeURIComponent('JSON');
	queryParams += '&' + encodeURIComponent('base_date') + '=' + encodeURIComponent(nowDate);
	queryParams += '&' + encodeURIComponent('base_time') + '=' + encodeURIComponent(nowTime);
	queryParams += '&' + encodeURIComponent('nx') + '=' + encodeURIComponent(Ma);
	queryParams += '&' + encodeURIComponent('ny') + '=' + encodeURIComponent(La);
	xhr.open('GET', url + queryParams);
	xhr.onreadystatechange = function () {
	    if (this.readyState == 4) {
	    	var temp = JSON.parse(this.responseText).response.body.items.item;
    		for (let i = 0; i < temp.length; i++) {
    			if (temp[i].category == 'TMP') {
	    			var temp2 = ['기온', temp[i].fcstValue];
	    			data[data.length] = temp2;
    			} else if (temp[i].category == 'pop') {
	    			var temp2 = ['강수확률', temp[i].fcstValue];
	    			data[data.length] = temp2;
    			} else {
	    			var temp2 = [temp[i].category, temp[i].fcstValue];
	    			data[data.length] = temp2;
	    		}
			}
			console.log(temp);
			weather_data.innerText = data;
	    }
	};
	
	xhr.send('');
}


