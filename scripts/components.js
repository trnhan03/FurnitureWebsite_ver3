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

// add to top
function addToTop() {
    document.write(`
    <a href="#" class="to-top">
        <i class="ti-angle-up"></i>
    </a>
    `)
}

