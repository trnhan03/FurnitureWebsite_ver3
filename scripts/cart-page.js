//get product from localStorage
function getProducts() {
    document.getElementsByClassName('cart-products')[0].innerHTML='';
    if(localStorage.length==0 || JSON.parse(localStorage.getItem('products')).length==0) {
        document.getElementsByClassName('cart-products')[0].innerHTML+=`
        
        <div class="cart">
        <img class="empty-cart" src="../img/Cart empty/cart-empty.png" alt="Empty Cart image">
        <p>Your cart is empty</p>
        </div>
        `
    }
    else {
        let total=0;
        document.getElementsByClassName('cart-products')[0].innerHTML+=`
                <div class="cart-headings">
                    <div class="product-detail-heading">Product</div>
                    <div class="product-total-headings">
                        <div class="product-price-heading">Price</div>
                        <div class="product-quantity-heading">Quantity</div>
                        <div class="product-total-heading">Total</div>
                    </div>
                </div>
        `
        let products=JSON.parse(localStorage.getItem("products"));
        products.forEach(product => {
            total+=product.producttotal;
            document.getElementsByClassName('cart-products')[0].innerHTML+=`
            <div class="cart-product">
                            <div class="product-detail">
                                <img src=${product.img} alt="" class="product-image">
                                <div class="product-item">
                                    <p class="product-name">${product.productname}</p>
                                </div>
                            </div>

                            <div class="product-total">
                                <div class="product-price">${product.productprice}</div>
                                <div class="cart-add-minus-button">
                                <button class="ti-minus" onclick="decreaseproduct('${product.productname}')"></button>
                                <div class="quantity" data-productname="${product.productname}">${product.productquan}</div>
                                <button class="ti-plus" onclick="increaseproduct('${product.productname}')"></button>
                                </div>
            
                                <div class="product-total-price">$${product.producttotal}</div>

                                <button class="trash-icon" onclick="removeCart('${product.productname}')">
                                <img src="../img/Cart empty/delete.png" alt="trash icon">
                                </button>
                            </div>
            </div>`
        })
        
        document.getElementsByClassName('cart-products')[0].innerHTML+=`
        <div class="cart-sub-total">
                        <div class="sub-total">
                            <div class="sub-total-title">Sub-total</div>
                            <div class="sub-total-price">$${total}</div>
                            <div class="sub-total-note">Tax and shipping will be calculated later</div>
                        </div>

                        <div class="check-out-button" >
                            <button onclick="goTo('billing-detail-page.html')"><span></span>Check-out</button>
                        </div>
        </div>
        `
    }
    console.log(JSON.parse(localStorage.getItem('products')).length)
}

//get product every load
window.addEventListener('load', function() {
    getProducts();
});

//remove cart
function removeCart(productt){
    products=[];
    products=JSON.parse(localStorage.getItem("products"))
    products=products.filter(product=>product.productname!=productt);
    localStorage.setItem('products',JSON.stringify(products))
    getProducts();
}

//increase Product
function increaseproduct(curr) {
    const cartList = JSON.parse(localStorage.getItem("products"));
    const quantityElement = document.querySelector(".quantity");
    const currentQuantity = parseInt(quantityElement.textContent);
    const updatedQuantity = currentQuantity + 1;
    quantityElement.textContent = updatedQuantity;

    const productToUpdate = cartList.find(product => product.productname === curr);
    productToUpdate.productquan = updatedQuantity;
    productToUpdate.producttotal = (updatedQuantity*parseFloat(productToUpdate.productprice));
    quantityElement.innerHTML.textContent = updatedQuantity;
    localStorage.setItem("products", JSON.stringify(cartList));
    console.log(productToUpdate.productprice);
    getProducts();
    
}
//decrease product
function decreaseproduct(curr) {
    const cartList = JSON.parse(localStorage.getItem("products"));
    const quantityElement = document.querySelector(".quantity");
    const currentQuantity = parseInt(quantityElement.textContent);
    const updatedQuantity = currentQuantity - 1;
    if(updatedQuantity <= 0 )
    {
        removeCart(curr);
    } else{
        quantityElement.textContent = updatedQuantity;
        const productToUpdate = cartList.find(product => product.productname === curr);
        productToUpdate.productquan = updatedQuantity;
        productToUpdate.producttotal = (updatedQuantity*parseFloat(productToUpdate.productprice));
        quantityElement.innerHTML.textContent = updatedQuantity;
        localStorage.setItem("products", JSON.stringify(cartList));
        getProducts();
    }
    
}