<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css/orders.css">
    <link rel="stylesheet" href="css/modal.css">

    <style>

    </style>

</head>

<body>
    <main id='top'>
        <img src="medias/Habibtea.png" alt="Logo HubSpot" />

        </div>

        <div class="dropdown">
            <div class="mycart" id="cart">
                <p><span class="myitems" id="in-cart-items-num">0 Articles</p>
            </div>
            <ul id="cart-dropdown" hidden>
                <li id="empty-cart-msg"><a>Empty Cart</a></li>
                <li class="go-to-cart-hidden"><a href="/cart">Checkout</a></li>
            </ul>
        </div>
        </div>

        <a class='top' href='#top'>top</a>
        <script src="js/orders.js"></script>
        <div class="wrap" id="bubbleteawrap"> </div>


        <div class="modal" id="modal">
            <form>
                <span onClick="closeModal()">
                    &times;</span>


                <span class="choose">Customize your drink</span>
                <span class="choose">Choose your temperature </span>
                <p class="choice">

                    <input type="radio" name="temp" /> Cold<br />
                    <input type="radio" name="temp" /> Brew<br />

                </p>

                <span class="choose">Choose your size </span>
                <p class="choice">

                    <input type="radio" name="size" /> Small<br />
                    <input type="radio" name="size" /> Medium <br />
                    <input type="radio" name="size" /> Large <br />
                </p>

                <span class="choose">Choose your sugar level</span>
                <p class="sugar">
                    <input type="radio" name="sugarlevel" /> 0%<br />
                    <input type="radio" name="sugarlevel" /> 30%<br />
                    <input type="radio" name="sugarlevel" /> 50%<br />
                    <input type="radio" name="sugarlevel" /> 75% <br />
                    <input type="radio" name="sugarlevel" /> 100%<br />
                </p>

                <span class="choose">Choose your toppings</span>
                <p class="choice">

                    <input type="radio" name="toppings" /> Tapioca pearls<br />
                    <input type="radio" name="toppings" /> Mango jelly pearls<br />
                    <input type="radio" name="toppings" /> Red fruits jelly pearls<br />
                    <input type="radio" name="toppings" /> Melon jelly pearls <br />
                    <input type="radio" name="toppings" /> Taro jelly pearls<br />
                </p>


                <span class="choose">Choose your quantity</span>
                <div class="myquantity">

                    <form id='myform' method='POST' class='quantity' action='#'>
                        <input type='button' value='-' class='qtyminus minus' field='quantity' />
                        <input type='text' name='quantity' value='1' class='qty' />
                        <input type='button' value='+' class='qtyplus plus' field='quantity' />

                    </form>
                </div>
            </form>

            <button onClick="getCommand(id, modalInformation)" class="add" value="boutton">Add to cart</button>

            <script src="js/modal.js"></script>
            <script src="js/orders.js"></script>

    </main>
    <a class='top' href='#top'>top</a>
</body>

</html><?php /**PATH /home/molok/git/Bubble_my_tea/habibtea/resources/views/orders.blade.php ENDPATH**/ ?>