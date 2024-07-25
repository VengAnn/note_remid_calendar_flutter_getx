<?php

namespace App\Http\Controllers\Api\V1\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Validator;

class AuthGoogleController extends Controller
{
    public function registerGoogleAuth(Request $request)
    {
        try {
            $input = $request->all();
            $validator = Validator::make($request->all(), [
                'name' => 'required',
                'email' => 'required|email',
            ]);
    
            if ($validator->fails()) {
                return response()->json(['error' => $validator->errors()], 401);
            }
    
            // Check if the email already exists
            $user = User::where('email', $input['email'])->first();
            if ($user) {
                // User exists
                $user_id = $user->user_id; // Assuming 'id' is the primary key
                $success['user_id'] = $user_id;
                $success['token'] = $user->createToken('MyApp')->accessToken;
                $success['email'] = $user->email;
                $success['name'] = $user->name;
                return response()->json(['success' => $success], 200);
            } else {
                // User does not exist, create a new user
                $newUser = User::create($input);
                $newUser_id = $newUser->user_id; // Assuming 'id' is the primary key
                $success['user_id'] = $newUser_id;
                $success['token'] = $newUser->createToken('MyApp')->accessToken;
                $success['name'] = $newUser->name;
                $success['email'] = $newUser->email;
                return response()->json(['success' => $success], 200);
            }
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }    
}
