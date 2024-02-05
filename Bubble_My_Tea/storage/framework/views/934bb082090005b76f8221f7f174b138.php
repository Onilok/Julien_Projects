<!-- resources/views/bubble/create.blade.php -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouvelle Commande de Bubble Tea</title>
</head>
<body>

    <h2>Nouvelle Commande de Bubble Tea</h2>

    <form method="POST" action="<?php echo e(url('order')); ?>">
        <?php echo csrf_field(); ?>

        <label for="bubble_name">Nom du Bubble Tea:</label>
        <input type="text" id="bubble_name" name="bubble_name" required>

        <br>

        <label for="quantity">Quantité:</label>
        <input type="number" id="quantity" name="quantity" required>

        <br>

        <label for="tea_type">Type de thé:</label>
        <input type="text" id="tea_type" name="tea_type" required>

        <br>

        <label for="sugar_level">Niveau de sucre:</label>
        <input type="text" id="sugar_level" name="sugar_level" required>

        <br>

        <label for="toppings">Toppings:</label>
        <input type="text" id="toppings" name="toppings" required>

        <br>

        <label for="price">Prix:</label>
        <input type="number" id="price" name="price" required>

        <br>
        <label for="temper">Temperature: </label>
        <input type="radio" id="cold" name="temper" value="0" required>
        <label for="cold">Cold</label>
        
        <input type="radio" id="warm" name="temper" value="1" required>
        <label for="warm">Warm</label>
        
        <br>
        
        <label for="size">Size: </label>
        <input type="radio" id="small" name="size" value="small" required>
        <label for="small">Small</label>
        
        <input type="radio" id="medium" name="size" value="medium" required>
        <label for="medium">Medium</label>
        
        <input type="radio" id="large" name="size" value="large" required>
        <label for="large">Large</label>

        <br>

        <button type="submit">Enregistrer la Commande</button>
    </form>

</body>
</html>
<?php /**PATH /home/molok/git/Bubble_my_tea/Bubble_My_tea/resources/views/order.blade.php ENDPATH**/ ?>