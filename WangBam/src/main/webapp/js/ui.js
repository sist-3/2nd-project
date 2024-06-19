// 메인 슬라이더
const swiper = new Swiper('.swiper', {
  // Navigation arrows
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },

  // And if we need scrollbar
  scrollbar: {
    el: '.swiper-scrollbar',
  },
});

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