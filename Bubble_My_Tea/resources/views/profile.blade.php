<<<<<<< HEAD
{{-- @extends('welcome') --}}
@section('title', 'profile')

@section('content')

    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
        integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" /> 
        <link rel="stylesheet" href="css/profile.css">
        <title>User Settings</title>
    </head>

    <body>
        <div>
            <div class="logo">
                <a href="#"><img src="LogoHabib'Tea.png"></a>
            </div>
            <header>
                <nav class= "header">
                    <ul>
                        <li class="Menu"><a href="X.html">Menu</a>
                            <ul class="submenu">
                                <li><a href="Dashboard"></a>Dashboard</li>
                                <li><a href="Logout"></a>Logout</li>
                            </ul>
                        </li>
                </nav>
            </header>
            <form class="container" action="{{route('profile')}}"  method="POST" >
                @csrf
                <h2 class="title-container">Edit Profile</h2>
                <div class="column">
                    <h3>First name</h3>
                    <input type="text" class="input" name ="name" required>
                    <h3>Email</h3>
                    <input type="email" class="input"  name ="email" required>
                    <h3>Adress</h3>
                    <input type="text" class="input" name ="address" required>
                    <h3>City</h3>
                    <input type="text" class="input" name ="city"  required>
                    <h3>Password</h3>
                    <input type="password" class="input" name ="password" required>
                </div>
                <div class="column">
                    <h3>Username</h3>
                    <input type="text" class="input" name = "username" required>
                    <h3>Phone number</h3>
                    <input type="text" class="input" name ="phone" required>
                    <h3>Postal code</h3>
                    <input type="number" class="input" name="postal_address" required>
                    <h3>Country</h3>
                    <input type="text" class="input" name="country" required>
                    <div>
                        <input  type="submit" class="btn">
                        
                    </div>
                </div>
            </form>
                    

                    
                  
    </body>

=======
<!-- resources/views/auth/profile.blade.php -->




    <div class="container">
        <form action="{{ url('profile') }}" method="POST">
            @csrf

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
>>>>>>> 310cd76 (:rocket: launch project with new name project)
