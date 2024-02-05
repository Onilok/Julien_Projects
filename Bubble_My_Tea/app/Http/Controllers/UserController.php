<?php

namespace App\Http\Controllers;


use App\Models\User;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{

    function profile(Request $request)
    {
        return view('profile');
    }
    function show(Request $request)
    {
        return view('register');
    }
    function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required',
            'username' => 'required',
            'email' => 'required|unique:' . User::class,
            'password' => 'required',
            'address' => 'required',
            'postal_address' => 'required',
            'country' => 'required',
            'city' => 'required',
            'phone' => 'required',
        ]);

        $validated['password'] = Hash::make($validated['password']);
        User::create($validated);
        return redirect('order');

    }



    // ...

    public function update_profile(Request $request)
    {
        // on met l'utilisateur actuelle sur $user
        $user = Auth::user();

        $validated_update = $request->validate([
            'name' => 'required',
            'username' => 'required',
            'email' => 'required',
            'password' => 'required',
            'address' => 'required',
            'postal_address' => 'required',
            'country' => 'required',
            'city' => 'required',
            'phone' => 'required',
        ]);

        $validated_update['password'] = Hash::make($validated_update['password']);


        $user->update($validated_update);

        return redirect('order');
    }

    function show_profile(Request $request)
    {
        return view('profile');
    }

    function show_login(Request $request)
    {
        return view('login');
    }
}