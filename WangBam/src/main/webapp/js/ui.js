$(document).ready(function() {
    applyFadeInAnimation();
    initializeAmazingButton();
    handleMenuToggle();
    checkAndInitializeGoogleTranslate();
    handleLanguageSelection();
});

function applyFadeInAnimation() {
    $('.content').addClass('fade-in');
}

function initializeAmazingButton() {
    $('.final-btn').on('click', function(e) {
        e.preventDefault();
        $(this).removeClass('animate');
        $(this).addClass('animate');
        setTimeout(() => {
            $(this).removeClass('animate');
        }, 700);
    });
}

function handleMenuToggle() {
    $('#menuOpenBtn').on('click', function() {
        $('#totalMenu').show();
        $('body').addClass('pop_open');
    });

    $('#menuCloseBtn').on('click', function() {
        $('#totalMenu').hide();
        $('body').removeClass('pop_open');
    });
}

function checkAndInitializeGoogleTranslate() {
    const currentUrl = window.location.href;
    const targetUrlPattern = 'admin';
    if (!isTargetUrl(currentUrl, targetUrlPattern)) {
        if (typeof google !== 'undefined' && google.translate && google.translate.TranslateElement) {
            googleTranslateElementInit();
        } else {
            window.googleTranslateElementInit = googleTranslateElementInit;
        }
    }
}

function isTargetUrl(url, pattern) {
    return url.includes(pattern);
}

function googleTranslateElementInit() {
    new google.translate.TranslateElement({
        pageLanguage: 'ko',
        includedLanguages: 'en,ko,ja'
    }, 'google_translate_element');
}

function handleLanguageSelection() {
    $('#language-selector').on('change', function() {
        const selectedLanguage = $(this).val();
        const translateElement = $('.goog-te-combo');
        if (translateElement.length) {
            translateElement.val(selectedLanguage);
            translateElement[0].dispatchEvent(new Event('change'));
        }
    });
}
