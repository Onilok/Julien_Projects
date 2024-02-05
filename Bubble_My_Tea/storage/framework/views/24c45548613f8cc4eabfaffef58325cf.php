<!DOCTYPE html>
<html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive Registration</title>
    <link rel="stylesheet" type="text/css" href="css/register.css" />
    <script src="https://kit.fontawesome.com/db2bf29261.js" crossorigin="anonymous"></script>

</head>

<body>

    <section class="container section-container">
        <div class="header">
            <h1>Registeration Form</h1>
            <form action="<?php echo e(route('register')); ?>" class="form" method="POST">
                <?php echo csrf_field(); ?>
                <div class="input-box">
                    <label>Full Name</label>
                    <input type="text" placeholder="Enter full name" name="name" required />
                </div>
                <div class="input-box">
                    <label>Email Address</label>
                    <input type="text" placeholder="Enter email Address" name="email" required />
                </div>
                <div class="column">
                    <div class="input-box">
                        <label>Username</label>
                        <input type="text" placeholder="username" name="username" required />
                        <div class="input-box">
                            <label>Phone Number</label>
                            <input type="text" placeholder="Enter phone number" name="phone" required />
                        </div>
                    </div>
                </div>
                <div class="column">
                    <div class="input-box">
                        <label>Password</label>
                        <input type="password" placeholder="password" name="password" required />
                    </div>
                </div>
                <div class="input-box address">
                    <label>Address</label>
                    <input type="text" placeholder="Enter street address" name="address" required /><br />

                    <div class="column">
                        <div class="select-box">
                            <label class="country">Country</label>
                            <select name="country">
                                <option hidden>Country</option>
                                <option>America</option>
                                <option>Japan</option>
                                <option>Egypt</option>
                                <option>France</option>
                                <option>Others</option>
                            </select>
                        </div>
                    </div>


                    <label> City</label> <input type="text" placeholder="Enter your city" name="city" required /><br />
                    <label> Postal code</label> <input type="number" placeholder="Enter postal code"
                        name="postal_address" required /><br />
                </div>
                <input type="submit">
            </form>
        </div>
    </section>


    <header>
        <nav class="banniÃ¨re">
            <ul>
                <li class="menu"><a href="X.html"><i class="fa-solid fa-bars"></i>&nbsp;Menu</a>
                    <ul class="submenu">
                        <li><a href="inscription ">Register</a></li>
                        <li><a href="login">Login</a></li>
                        <li><a href="">Our Bubble Teas</a></li>
                    </ul>
                </li>
            </ul>

        </nav>
    </header>

    <footer>
        <br />
        <div id="footer">
            | <a href="#">need help</a>
            |<a href="#">conditions</a>
    </footer>
</body>

</html><?php /**PATH /home/molok/git/Bubble_my_tea/habibtea/resources/views/register.blade.php ENDPATH**/ ?>