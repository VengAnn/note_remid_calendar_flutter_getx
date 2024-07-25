note : when laravel passort error : RuntimeException: Personal access client not found. Please create one. in file C:\Users\vengann\Desktop\Thuc_tap_chuyen_nganh\my_backend_calendar\vendor\laravel\passport\src\ClientRepository.php on line 122

let's run this command: php artisan passport:client --personal 


Step 1: Install Laravel Passport
Run composer require laravel/passport to install Laravel Passport.
After installing, run php artisan migrate to migrate the necessary tables for Passport.
Next, run php artisan passport:install to generate the encryption keys needed for Passport.
Step 2: Configure Passport
In your config/auth.php file, set the api driver to passport.
php
Copy code
'guards' => [
    'api' => [
        'driver' => 'passport',
        'provider' => 'users',
    ],
]
In your App\User model, use the HasApiTokens trait.
php
Copy code
use Laravel\Passport\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, Notifiable;
}
Step 3: Create or Modify Database Schema
To create a new migration, run php artisan make:migration create_new_table.
Open the migration file created in database/migrations directory.
Define the schema changes in the up method.
php
Copy code
Schema::create('new_table', function (Blueprint $table) {
    $table->id();
    $table->string('new_column');
    // Add more columns as needed
    $table->timestamps();
});
Run php artisan migrate to apply the migration and create the new table.
Step 4: Add More Fields to Existing Table
To modify an existing table's schema, create a new migration using php artisan make:migration add_columns_to_existing_table.
Open the generated migration file.
Use the table method to modify the existing table schema.
php
Copy code
Schema::table('existing_table', function (Blueprint $table) {
    $table->string('new_column')->nullable();
    // Add more columns as needed
});
Run php artisan migrate to apply the migration and modify the existing table.
Step 5: Use Passport in Routes and Controllers
Protect your API routes by applying the auth:api middleware.
php
Copy code
Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});
Generate API tokens for users using Passport's createToken method in your controllers.
php
Copy code
$accessToken = $user->createToken('MyApp')->accessToken;


////////////////////////////////////
+ php artisan make:migration create_events_table
+ php artisan make:migration create_reminders_table

+ php artisan make:controller EventController or php artisan make:controller Api/V1/EventController
+ php artisan make:controller ReminderController or php artisan make:controller Api/V1/ReminderController

+ php artisan make:model Event
+ php artisan make:model Reminder

