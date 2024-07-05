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
// 페이지 전환
document.addEventListener('DOMContentLoaded', function() {
    const page = document.querySelector('.content');
    // 페이지가 로드될 때 fadeIn 애니메이션 적용
    page.classList.add('fade-in');
    new google.translate.TranslateElement({pageLanguage: 'ko' , includedLanguages : 'ko,en,ja,zh-CN'}, 'google_translate_element');
});
