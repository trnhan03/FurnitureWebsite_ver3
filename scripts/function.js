// Scroll button
window.addEventListener("scroll", function() {
    const toTop = document.querySelector(".to-top");
    var scrollTop = window.scrollY;
    if(scrollTop > 0) {
        toTop.classList.add('active');
    } else {
        toTop.classList.remove('active');
    }
});



// Change Header color
// window.addEventListener('scroll', function() {
//     var header = document.querySelector('.header-web');
//     var scrollPosition = window.scrollY;

//     if (scrollPosition > 0) {
//         header.classList.add('scrolled');
//     } else {
//         header.classList.remove('scrolled');
//     }
// });


// Open Search Box
const searchBtn = document.querySelector('.search-button-navigation');
const searchInput = document.querySelector('#search');

searchBtn.addEventListener('click', () => {
    if (searchInput.style.opacity === '0') {
        searchInput.style.opacity = '1';
    } else {
        searchInput.style.opacity = '0';
    }
})

//change page
function goTo(x) {
    location.href=x;   
   }