<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Bubble extends Model
{
    use HasFactory;

    protected $table = 'bubble';
    protected $fillable = [
        'bubble_name',
        'quantity',
        'sugar_level',
        'toppings',
        'price',
        'id_user',
        'temper',
        'size',

    ];

    private $bubble_name;

    protected $connection = 'mysql';
}