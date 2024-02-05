<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css/modal.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>

<body>

    <span class="choose">Customize your drink !</span>

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

    <span class="choose">Choose your base</span>
    <p class="choice">

        <input type="radio" name="base" /> Milk<br />
        <input type="radio" name="base" /> Black tea<br />
        <input type="radio" name="base" /> Green Tea<br />
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
            <script src="js/modal.js"></script>
        </form>
    </div>


    <button class="add" value="boutton">Add to cart</button>


</body>

</html>