<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('bubble', function (Blueprint $table) {
            $table->id();
            $table->string('bubble_name');
            $table->integer('quantity');
            $table->string('sugar_level');
            $table->string('toppings'); // exemple, perles de fruits, perles de coco..........
            $table->integer('price');
            $table->boolean('temper');
            $table->string('size');
            $table->unsignedBigInteger('user_id');
            $table->foreign('user_id')->references('id')->on('users');
            $table->timestamps();


        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
    }
};