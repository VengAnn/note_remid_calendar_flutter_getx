<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->increments('user_id'); // Auto-incrementing user_id
            $table->string('name');
            $table->string('email')->unique();
            $table->string('password')->nullable(); // because user can login with google authentication, so we need savve only email that logined with google authentication
            $table->string('profile_url')->nullable(); // Allow null values
            $table->boolean('status')->default(false);
            $table->timestamps(); // Add created_at and updated_at columns
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
};
