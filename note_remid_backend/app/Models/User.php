<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
# use Laravel\Sanctum\HasApiTokens;
use Laravel\Passport\HasApiTokens;  //add the laravel passport 

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $primaryKey = 'user_id'; // Specify the custom primary key

    protected $fillable = [
        'user_id', 'name', 'email', 'password','profile_url',
    ];

    protected $hidden = [
        'password', 'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
    ];
}
