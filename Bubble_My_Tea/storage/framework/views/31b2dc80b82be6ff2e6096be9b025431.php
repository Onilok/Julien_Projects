<!-- resources/views/auth/login.blade.php -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion</title>
</head>
<body>

    <h2>Connexion</h2>
    <h2>if the login or password isn't good retry</h2>
    
    <form method="POST" action="<?php echo e(url('login')); ?>">
        <?php echo csrf_field(); ?>

        <label for="email">Adresse email:</label>
        <input type="email" id="email" name="email" required>

        <br>

        <label for="password">Mot de passe:</label>
        <input type="password" id="password" name="password" required>

        <button type="submit">Connexion</button>
        
    </form>
    
   

</body>
</html>
<?php /**PATH /home/molok/git/Bubble_my_tea/Bubble_My_tea/resources/views/login.blade.php ENDPATH**/ ?>