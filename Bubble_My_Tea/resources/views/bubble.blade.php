
<html>
    <body>
        <h1>Users Page</h1>
        <br>
        <ul>
            @foreach($Bubbles as $bubble)
                <li>{{$bubble->bubble_name}}</li>
            @endforeach
        </ul>
    </body>
</html>



