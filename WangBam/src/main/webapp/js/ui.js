// 엄청난버튼
const animateButton = function (e) {
	e.preventDefault;
	//reset animation
	e.target.classList.remove('animate');

	e.target.classList.add('animate');
	setTimeout(function () {
		e.target.classList.remove('animate');
	}, 700);
};

const bubblyButtons = document.querySelectorAll('.final-btn');

for (let i = 0; i < bubblyButtons.length; i++) {
	bubblyButtons[i].addEventListener('click', animateButton, false);
}
function googleTranslateElementInit() {new google.translate.TranslateElement({pageLanguage: 'ko' , includedLanguages : 'en,ko,ja'}, 'google_translate_element');}
// 페이지 전환
document.addEventListener('DOMContentLoaded', function() {
    const page = document.querySelector('.content');
    // 페이지가 로드될 때 fadeIn 애니메이션 적용
    page.classList.add('fade-in');
    googleTranslateElementInit();
});

// 언어 선택 이벤트 핸들러
document.getElementById('language-selector').addEventListener('change', function() {
    const selectedLanguage = this.value;
    const translateElement = document.querySelector('.goog-te-combo');
    if (translateElement) {
        translateElement.value = selectedLanguage;
        translateElement.dispatchEvent(new Event('change'));
    }
});
$("#menuOpenBtn").on('click', function(){
	$("#totalMenu").show();
	$("body").addClass("pop_open");
})
$("#menuCloseBtn").on('click', function(){
	$("#totalMenu").hide();
	$("body").removeClass("pop_open");
})