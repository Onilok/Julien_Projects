<?php

namespace App\Http\Controllers;


use App\Models\Bubble;
use Illuminate\Http\Request;

use Illuminate\Support\Facades\Auth;



class BubbleController extends Controller
{

    public function store(Request $request)
    {


        // on met tout dans res
        // $res = $request->all();

        // $bubble = new bubble();
        // $bubble->bubble_name = $res['bubble_name'];
        // $bubble->quantity = $res['quantity']; // quantity en marron c'est l'id dans le html
        // $bubble->sugar_level = $res['sugar_level'];
        // $bubble->toppings = $res['toppings'];
        // $bubble->price = $res['price'];
        // $bubble->temper = $res['temper'];
        // $bubble->size = $res['size'];
        // $bubble->user_id = 3;

        // $bubble->save();


        // return redirect('order');


        $validated_bubble = $request->validate([[
            $id_user = Auth::user()->id,
            'id_user' => $id_user,
            'bubble_name' => 'required',
            'quantity' => 'required',
            'sugar_level' => 'required',
            'toppings' => 'required',
            'price' => 'required',
            'temper' => 'required',
            'size' => 'required',
        ]]);
        print($validated_bubble);
        // Bubble::create($validated_bubble);
        // return redirect('order');

    }

    public function show(Request $request)
    {
        return view('order');
    }

    public function show_orders(Request $request)
    {
        return view('orders');
    }
}