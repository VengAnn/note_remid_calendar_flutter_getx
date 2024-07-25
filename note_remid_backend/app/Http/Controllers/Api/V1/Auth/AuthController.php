<?php

namespace App\Http\Controllers\Api\V1\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Validator;
use App\Models\User;
use Illuminate\Support\Facades\Auth;



class AuthController extends Controller
{
    public function register(Request $request)
    {
        try {
            $input = $request->all();
            $validator = Validator::make($request->all(), [
                'name' => 'required',
                'email' => 'required|email',
                'password' => 'required|min:5', // required password at least 5 characters
            ]);
    
            if ($validator->fails()) {
                return response()->json(['error' => $validator->errors()], 401);
            }
    
            // Check if the email already exists
            if (User::where('email', $input['email'])->exists()) {
                return response()->json(['error' => 'Email already exists'], 409);
            }
    
            // Store the image if provided
            if ($request->hasFile('image')) {
                $image = $request->file('image');
                $name = time() . '.' . $image->getClientOriginalExtension();
                $destinationPath = public_path('/users');
                $image->move($destinationPath, $name);
                $input['profile_url'] = $name;
            }
    
            $input['password'] = bcrypt($input['password']);
            $user = User::create($input);
            $success['token'] =  $user->createToken('MyApp')->accessToken;
            $success['name'] =  $user->name;

            return  response()->json(['succes' => $success, 'data' => $input],200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function login(Request $request)
    {
        try {
            if (Auth::attempt(['email' => $request->email, 'password' => $request->password])) {
                $user = Auth::user();
                $user->makeHidden(['created_at', 'updated_at']);
                $token =  $user->createToken('MyApp')->accessToken;

                return response()->json(['user' => $user, 'token' => $token], 200);
            } else {
                return response()->json(['error' => 'Unauthorised or email password wrong!'], 401);
            }
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    //check get current user login
    public function me()
    {
        try {
            $user = Auth::user(); //get current logged in user
            return response()->json(['user' => $user], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    //when user logout remove token;
    public function logout()
    {
        try {
            $user = Auth::user()->token();
            $user->revoke();
            return response()->json(['message' => 'Successfully logout'], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    //allow user to can be upadate profile url 
    public function updateUser(Request $request)
    {
        try {
            $data = $request->all();
            $user = Auth::user();
            if ($user != null) {
                if ($request->hasFile('image')) {
                    $image = $request->file('image');
                    $name = time() . '.' . $image->getClientOriginalExtension();
                    $destinationPath = public_path('/images');
                    $image->move($destinationPath, $name);
                    $data['profile_url'] = $name;
                    $oldImage =  $user->profile_url; //check oldImage for delete old on path public server
                }
                $user->update($data);
                $destinationPath = public_path('/images');

                //if existsfile delete oldimage
                if (file_exists($destinationPath . '/' . $oldImage)) {
                    unlink($destinationPath . '/' . $oldImage);
                }
                return response()->json(['user' => $user], 200);
            } else {
                return response()->json(['error' => 'unauthorised'], 401);
            }
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
}
