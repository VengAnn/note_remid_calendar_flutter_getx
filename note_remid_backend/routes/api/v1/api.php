<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\V1\Auth\AuthController;
use App\Http\Controllers\Api\V1\EventController;

use App\Http\Controllers\Api\V1\Auth\AuthGoogleController; // Update import statement

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// namespace Api\V1 is controller auth in this folder
Route::group(['namespace' => 'Api\V1'], function () {

    // Auth Routes
    Route::group(['prefix' => 'auth'], function () {
        // endpoint like: http://127.0.0.1:8000/api/v1/auth/register
        Route::post('register', [AuthController::class, 'register']);
        Route::post('login', [AuthController::class, 'login']);

        Route::post('register-google', [AuthGoogleController::class, 'registerGoogleAuth']);

        Route::get('me', [AuthController::class, 'me'])->middleware('auth:api');
        Route::post('logout', [AuthController::class, 'logout'])->middleware('auth:api');
        Route::post('update-user', [AuthController::class, 'updateUser'])->middleware('auth:api');
    });
    // end auth routes

     // route or endpoint events
     Route::group(['prefix' => 'events'], function () {
        Route::get('/', [EventController::class, 'index']);
        Route::get('/{id}', [EventController::class, 'show']);
        Route::get('/user/{userId}', [EventController::class, 'getEventsByUserId']);

        Route::post('/', [EventController::class, 'store'])->middleware('auth:api');
        Route::put('/{id}', [EventController::class, 'update'])->middleware('auth:api');
        Route::delete('/{id}', [EventController::class, 'destroy'])->middleware('auth:api');
    });


     // endpoint events
    //  Route::group(['prefix' => 'reminders'], function () {
    //     Route::get('/', [ReminderController::class, 'index']);
    //     Route::get('/{id}', [ReminderController::class, 'show']);
    //     Route::post('/', [ReminderController::class, 'store'])->middleware('auth:api');
    //     Route::put('/{id}', [ReminderController::class, 'update'])->middleware('auth:api');
    //     Route::delete('/{id}', [ReminderController::class, 'destroy'])->middleware('auth:api');
    // });
});
