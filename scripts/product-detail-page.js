//add product to localStorage

function addtocart(curr) {
    let products=[];
    let img=curr.parentElement.parentElement.children[2].children[0].src;
    let productname=curr.parentElement.parentElement.children[1].textContent.trim();
    let productprice=curr.parentElement.parentElement.children[3].children[0].textContent.trim();
    let productquan=curr.parentElement.parentElement.children[5].children[0].children[1].textContent.trim();
    productprice=productprice.slice(1);
    productprice=productprice.replace(',','.');
    let producttotal=parseFloat(productquan)*parseFloat(productprice);
    if (localStorage.length!=0 ) {
        products.push(...JSON.parse(localStorage.getItem("products")));
      }
    
    let product={
    img:img,
    productname:productname,
    productprice:productprice,
    productquan:productquan,
    producttotal:producttotal
    };
    let isExist=products.some(x=>x.img==product.img&&x.productname==product.productname&&x.productprice==product.productprice);
    if(!isExist) {
        products.push(product);  
    }
    else alert("This product has been added to cart")
     
    localStorage.setItem("products", JSON.stringify(products));
    
}

//increase quantity
function increasequan(curr) {
    quantity=curr.parentElement.children[1];
    quantity.innerHTML=Number(quantity.textContent)+1;
}
//decrease quantity
function decreasequan(curr) {
    quantity=curr.parentElement.children[1];
    if(Number(quantity.textContent)>1) {
        quantity.innerHTML=Number(quantity.textContent)-1;
    }
}