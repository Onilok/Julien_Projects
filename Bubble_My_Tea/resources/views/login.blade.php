<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>login</title>
    <script src="js/login.js"></script>
    <link rel="stylesheet" type="text/css" href="css/login.css" />
    <link href='https://unpkg.com/boxicon@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>

<body>


    </div>

    </a>
    </div>
    </div>
    </div>

    <header>
        <nav class="bannière">
            <ul>
                <li class="menu"><a href="X.html">Menu</a>
                    <ul class="submenu">
                        <li><a href="inscription ">Register</a></li>
                        <li><a href="login">Login</a></li>
                        <li><a href="">Our Bubble Teas</a></li>
                    </ul>
                </li>

        </nav>

    </header>

    <section>

        <img id="logo" src="PROMO-removebg-preview.png" alt="logo du site" width="350px" height="350px" />
        <div class="wrapper">
            <form id="form" type="submit" action="{{ route('login')}}" method="POST">
                {{ csrf_field() }}
                <h1>LOGIN</h1>
                <div class="input-box">
                    <input type="email" placeholder="email" name="email" required>
                    <i class='bx bxs-user'></i>
                </div>
                <div class="input-box">
                    <input type="password" placeholder="Password" name="password" required>
                    <i class='bx bxs-lock-alt'></i>
                </div>
                <div class="remember-forgot">
                    <label><input type="checkbox"> Remember me</label>
                    <a href="#"> Forget password?</a>
                </div>
                <button type="submit" class="btn">Send</button>

                <div class="register-link">
                    <a href="register ">Don't have an account? </a>
                </div>
            </form>
        </div>
    </section>


    <footer>
        <br />

        <div id="ft">
            | <a href="#">à propos</a>
            |<a href="#">nous contacter</a> |


        </div>


    </footer>
</body>

</html>