<!-- resources/views/auth/inscription.blade.php -->

<form action="<?php echo e(route('register')); ?>" method="POST">
    <?php echo csrf_field(); ?>

    <div>
        <label for="name">name:</label>
        <input type="text" name="name" id="name" required>
    </div>

    <div>
        <label for="username">username:</label>
        <input type="text" name="username" id="username" required>
    </div>

    <div>
        <label for="email">Email:</label>
        <input type="email" name="email" id="email" required>
    </div>

    <div>
        <label for="address">Adress:</label>
        <textarea name="adress" id="address" required></textarea>
    </div>

    <div>
        <label for="postal_address">postal_address:</label>
        <input type="text" name="postal_adress" id="postal_address" required>
    </div>

    <div>
        <label for="city">city:</label>
        <input type="text" name="city" id="city" required>
    </div>

    <div>
        <label for="countries">countries:</label>
        <input type="text" name="countries" id="countries" required>
    </div>

    <div>
        <label for="password">password:</label>
        <input type="password" name="password" id="password" required>
    </div>

    <div>
        <label for="phone">phone:</label>
        <input type="text" name="phone" id="phone" required>
    </div>

    <button type="submit">S'inscrire</button>
</form>
<?php /**PATH /home/molok/git/Bubble_my_tea/Bubble_My_tea/resources/views/register.blade.php ENDPATH**/ ?>