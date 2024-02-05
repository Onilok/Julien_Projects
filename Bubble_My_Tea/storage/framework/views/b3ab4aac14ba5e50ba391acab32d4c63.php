<!-- resources/views/auth/profile.blade.php -->




    <div class="container">
        <form action="<?php echo e(url('profile')); ?>" method="POST">
            <?php echo csrf_field(); ?>

            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" name="name" id="name" class="form-control"  required>
            </div>

            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" name="username" id="username" class="form-control"   required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" name="email" id="email" class="form-control"  required>
            </div>

            <div class="form-group">
                <label for="address">Address:</label>
                <textarea name="address" id="address" class="form-control" required></textarea>
            </div>

            <div class="form-group">
                <label for="postal_address">Postal Address:</label>
                <input type="text" name="postal_address" id="postal_address" class="form-control"  required>
            </div>

            <div class="form-group">
                <label for="city">City:</label>
                <input type="text" name="city" id="city" class="form-control"  required>
            </div>

            <div class="form-group">
                <label for="countries">Countries:</label>
                <input type="text" name="countries" id="countries" class="form-control"  required>
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" name="password" id="password" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="text" name="phone" id="phone" class="form-control"  required>
            </div>

            <button type="submit" class="btn btn-primary">Update Profile</button>
        </form>
    </div>
<?php /**PATH /home/molok/git/Bubble_my_tea/Bubble_My_tea/resources/views/profile.blade.php ENDPATH**/ ?>