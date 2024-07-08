/**
 * 조아요 기능 자바스크립트
 */
 
function addHeart(bo_idx, us_idx){
	$.ajax({
		url: "?type=boardsHeart",
		type: "post",
		data: { doCheck: "add",
				bo_idx: bo_idx,
				us_idx: us_idx}
	}).done(function(res){
		$("#boards_heart").html($(res).find("#boards_heart").html());
		// 하트 요소에 애니메이션 클래스 추가
        var heartElement = $("#boards_heart");
        heartElement.addClass("heart-animation-on");

        // 애니메이션이 끝난 후 클래스를 제거
        heartElement.on("animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd", function(){
            heartElement.removeClass("heart-animation-on");
        });
	});
}

function removeHeart(bo_idx, us_idx){
	$.ajax({
		url: "?type=boardsHeart",
		type: "post",
		data: { doCheck: "remove",
				bo_idx: bo_idx,
				us_idx: us_idx}
	}).done(function(res){
		$("#boards_heart").html($(res).find("#boards_heart").html());
		
        var heartElement = $("#boards_heart");
        heartElement.addClass("heart-animation-off");

        heartElement.on("animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd", function(){
            heartElement.removeClass("heart-animation-off");
        });
	});
	
}

function loginConfirm(){
	var goLogin = confirm("로그인 하시겠습니까?");
	if(goLogin){
		location = "?type=login";
	}
}