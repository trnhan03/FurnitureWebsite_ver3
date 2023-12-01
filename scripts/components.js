//add header
function addHeader() {
    document.write(`
    <header>
        <section id="navigation">
            <div class="logo-navigation">
                <a href="#" onclick="goTo('home-page.html')">Furnishity.</a>
            </div>

            <div class="list-navigation">
                <ul>
                    <li class="navigation-attribute">
                        <div class="text-navigation">
                            <a href="#" onclick="goTo('home-page.html')">Home</a>
                            <a href="#" onclick="goTo('shop-all.html')">Products</a>
                            <a href="#">Blog</a>
                            <a href="#" onclick="goTo('about-us-page.html')">About us</a>
                        </div>

                        <div class="icon-navigation"> 
                            <div class="search-box">
                                <input type="text" id="search" placeholder="Search">
                                <button class="search-button-navigation">
                                    <i class="fa-solid fa-magnifying-glass" style="color: #000000;"></i>
                                </button>
                            </div>  
                            
                            <div class="cart-box" onclick="goTo('cart-page.html')"> 
                                <button class="cart-button-navigation">
                                    <i class="fa-solid fa-cart-shopping" style="color: #000000;"></i>
                                </button>
                            </div>

                            <div class="heart-box">
                                <button class="heart-button-navigation" onclick="goTo('wishlist-screen.html')">
                                    <i class="fa-regular fa-heart" style="color: #000000;"></i>
                                </button>
                            </div>

                            <div class="user-box">
                                <button class="user-button-navigation">
                                    <i class="fa-regular fa-user" style="color: #000000;"></i>
                                </button>
                                <ul class="ti-user-attribute">
                                    <li class="profile-page">
                                        <a href="#">My profile</a>
                                    </li>
                                    <li class="my-order">
                                        <a href="#">My order</a>
                                    </li>
                                    <li class="log-out">
                                        <button>Logout</button>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </section>
    </header>
    `)
}

// add footer
function addFooter() {
    document.write(`
    <footer>
        <div class="footer-web">
            <div class="footer-row">
                <div class="footer-part a">
                    <h2>Furnishity</h2>
                    <p>We sell over 3000+ branded products since 2018</p>
                    <ul class="footer-a">
                        <li>
                            <a href="javascript:void(0)">
                                <i class="ti-mobile"></i>
                                0987654321
                            </a>
                        </li>
                        <li>
                            <a href="https://uit.edu.vn">
                                <i class="ti-location-pin"></i>
                                University of Information and Technology
                            </a>
                        </li>
                        <li>
                            <a href="home-page.html">
                                <i class="ti-world"></i>
                                www.furnishity.com
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="footer-part b">
                    <h2>Menu</h2>
                    <ul class="footer-b">
                        <li>
                            <a href="#" onclick="goTo('shop-all.html')">
                                Products
                            </a>
                        </li>
                        <li>
                            <a href="javascript:void(0)" >
                                Blog
                            </a>
                        </li>
                        <li>
                            <a href="#"onclick="goTo('about-us-page.html')">
                                About us
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="footer-part c">
                    <h2>Stay Connected</h2>
                    <ul class="footer-a">
                        <li>
                            <a href="https://facebook.com">
                                <i class="ti-facebook"></i>
                                Facebook
                            </a>
                        </li>
                        <li>
                            <a href="https://www.instagram.com/">
                                <i class="ti-instagram"></i>
                                Instagram
                            </a>
                        </li>
                        <li>
                            <a href="https://twitter.com/">
                                <i class="ti-twitter-alt"></i>
                                Twitter
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="footer-part d">
                    <h2>Stay Updated</h2>
                    <ul>
                        <li>
                            <a href="javascript:void(0)">Enter your email</a>
                        </li>
                        <i class="ti-check"></i>
                    </ul>
                </div>
            </div>
        </div>
    </footer>
    `)
}

//Change Header color
window.addEventListener('scroll', function() {
    var header = document.querySelector('#navigation');
    // var header = document.querySelector('#navigation');
    var scrollPosition = window.scrollY;

    if (scrollPosition > 0) {
        header.classList.add('scrolled');
    } else {
        header.classList.remove('scrolled');
    }
});

// add to top
function addToTop() {
    document.write(`
    <a href="#" class="to-top">
        <i class="ti-angle-up"></i>
    </a>
    `)
}

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

//Change Header color
window.addEventListener('scroll', function() {
    var header = document.querySelector('#navigation');
    // var header = document.querySelector('#navigation');
    var scrollPosition = window.scrollY;

    if (scrollPosition > 0) {
        header.classList.add('scrolled');
    } else {
        header.classList.remove('scrolled');
    }
});


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










// function removeProduct(curr) {
//     products=[];
//     products=JSON.parse(localStorage.getItem("products"))
//     products=products.filter(product=>product.img!=curr.parentElement.parentElement.children[0].src);
//     localStorage.setItem('products',JSON.stringify(products))
//     getProducts();
// }

// Check email
// var isEmailFilled = false; // Trạng thái nhập liệu email
// function checkEmail() {
//     var email = document.getElementById('email-field').value;
//     var pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
//     var emailMessage = document.getElementById('email-message');
    
//     if (isEmailFilled) { // Kiểm tra trạng thái nhập liệu email
//     if (pattern.test(email) && email.endsWith('@gmail.com')) {
//         emailMessage.textContent = 'Valid Email!';
//         emailMessage.style.color = 'green';
//     } else {
//         emailMessage.textContent = 'Invalid Email!';
//         emailMessage.style.color = 'red';
//     }
//     } else {
//     emailMessage.textContent = ''; // Xóa nội dung thông báo
//     }
// }
// function onEmailInput() {
//     isEmailFilled = document.getElementById('email-field').value.trim() !== ''; // Cập nhật trạng thái nhập liệu email
//     checkEmail();
// }

// // Check phone numbers
// var isSdtFilled = false; // Trạng thái nhập liệu số điện thoại
// function CheckPhoneNumbers() {
//     var phoneNumbers = document.getElementById('numbers').value;
//     var messageElement = document.getElementById('numbers-message');

//     // Xóa khoảng trắng ở đầu và cuối số điện thoại
//     phoneNumbers = phoneNumbers.trim();
    
//     if (isSdtFilled) { // Kiểm tra trạng thái nhập liệu số điện thoại
//     if (phoneNumbers.length === 10 && phoneNumbers.startsWith('0')) {
//         messageElement.textContent = 'Valid phone number!';
//         messageElement.style.color = 'green';
//     } else {
//         messageElement.textContent = 'Invalid phone number!';
//         messageElement.style.color = 'red';
//     }
//     } else {
//     messageElement.textContent = ''; // Xóa nội dung thông báo
//     }
// }
// function onPhoneNumberInput() {
//     isSdtFilled = document.getElementById('numbers').value.trim() !== ''; // Cập nhật trạng thái nhập liệu số điện thoại
//     CheckPhoneNumbers();
// }

// // function CheckSectionDisplay(num) {
// //     var array = ['home-page', 'products-page', 'product-detail-page', 'about-us-page', 'cart-page', 'billing-detail-page', 'shop-all'];
    
// //     for (var i = 0; i < array.length; i++) {
// //         if (i === num) {
// //             if(num==4) { getProducts()};
// //             document.getElementById(array[i]).style.display = 'block';
// //             document.getElementById(array[i]).scrollIntoView({ behavior: 'smooth', block: 'start' });
// //         } else {
// //             document.getElementById(array[i]).style.display = 'none';
// //         }
// //     }
// // }

// // Hide all sections except for homepage section

// // window.addEventListener('load', function() {
// //     var sections = document.getElementsByTagName('section');
// //     for (var i = 0; i < sections.length; i++) {
// //         if (sections[i].id !== 'home-page') {
// //             sections[i].style.display = 'none';
// //         }
// //     }
// // });



// // Add products 

// // Demo data
// const productList = {
//     "1": { "name": 'Product A', "image": './assets/Furniture_Photos/Products_Photos/P0004/1.webp', "price": 1.223},
//     "2": { "name": 'Product B', "image": './assets/Furniture_Photos/Products_Photos/P0005/1.webp', "price": 3.111 },
//     "3": { "name": 'Product C', "image": './assets/Furniture_Photos/Products_Photos/P0006/1.webp', "price": 2.509 },
//     /// n products
// };
// const productListnew = JSON.stringify(productList);
// localStorage.setItem("productList", productListnew);
// document.addEventListener("DOMContentLoaded", function() {
//     addProduct();
//  });
//  function addProduct(){
//     const itemList = JSON.parse(localStorage.getItem("productList"));
//     for (let key in itemList) {
//         if (itemList.hasOwnProperty(key)) {
//             const product = itemList[key];
//             document.getElementsByClassName('product-bed')[0].innerHTML += `
//                 <div class="product-1" onclick="CheckSectionDisplay(2)">
//                     <img src="${product.image}" alt="The Eldridge Bed" class="product-img">
//                     <div class="product-intro">
//                         <p class="product-name">${product.name}</p>
//                         <p class="product-cost">$${product.price}</p>
//                     </div>
//                 </div>`;
//         }
//     }
//  }

//  // Create Bill PDF document
//  function generatePDF(){
//     if (document.getElementById("first-name-input").value == "") {
//         alert("Please enter first name");
//       } else {
//         var doc = new jsPDF();
    
//         // Set font size and style for "Bill Details"
//         doc.setFontSize(18);
//         doc.setFontStyle("bold");
    
//         // Calculate the width of the text
//         var textWidth = doc.getStringUnitWidth("Bill Details") * doc.internal.getFontSize();
    
//         // Calculate the center position of the page with an offset
//         var pageWidth = doc.internal.pageSize.getWidth();
//         var offsetX = 32; // Adjust the value to move the text to the right
//         var centerX = (pageWidth - textWidth) / 2 + offsetX;
    
//         // Center the "Bill Details" text
//         doc.text(centerX, 30, "Bill Details");
//         doc.setFontSize(25);
//         var textWidthLogo = doc.getStringUnitWidth("Furnishity.") * doc.internal.getFontSize();
//         doc.text(10, 10,"Furnishity.");
//         // Reset font size and style for other text
//         doc.setFontSize(11);
//         doc.setFontStyle("normal");
        
//         var fullName = document.getElementById("last-name-input").value + " " + document.getElementById("first-name-input").value;

//     // Display
        
//         doc.text(pageWidth - 60, 40, "Brand: " + "Furnishity Store");
//         doc.text(pageWidth - 75, 45, "University of Information and Technology");
//         doc.text(pageWidth - 60, 50, "Phone Number: " + "0987654321");
//         doc.text(pageWidth - 60, 55, "Website: " + "www.furnishity.com");
//         doc.text(10, 60, "Full Name: " + fullName);
//         doc.text(10, 65, "Address: " + document.getElementById("address-input").value);
//         doc.text(10, 70, "Apartment: "+ document.getElementById("info-apartment-input").value);
//         doc.text(10, 75, "Town/City: "+ document.getElementById("info-city-input").value);
//         doc.text(10, 80, "Phone Number: "+ document.getElementById("numbers").value);
//         doc.text(10, 85, "Email: "+ document.getElementById("email-field").value);
//         doc.text(10, 95, "Product Name");
//         doc.text(100, 95, "Quantity")
//         doc.text(190, 95, "Price");
//         var productName = document.querySelector('.shipment-product-name').textContent;
//         var productPrice = document.querySelector('.shipment-product-price').textContent;
//         doc.text(10, 105, productName);
//         doc.text(105, 105, "1");
//         doc.text(190, 105, productPrice);
//         // Draw a line below the labels
//         var lineY = 97; // Adjust the value to position the line
//         var lineWidth = 190; // Adjust the value to set the width of the line
//         doc.line(10, lineY, 10 + lineWidth, lineY);
//         doc.save("invoice.pdf");
//       }
// }





