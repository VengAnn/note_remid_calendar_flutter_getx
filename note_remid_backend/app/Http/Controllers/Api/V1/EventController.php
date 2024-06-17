<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Event;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class EventController extends Controller
{
    public function index()
    {
        try {
            $events = Event::all();
            return response()->json($events, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Could not retrieve events'], 500);
        }
    }

    public function store(Request $request)
    {
        // Validate the request data
        $validator = Validator::make($request->all(), [
            'user_id' => 'required',
            'title' => 'required|string|max:255',
            'note' => 'nullable|string',
            'date'=>'required',
            'start_time' => 'required',
            'end_time' => 'required',
            'Remind' => 'required|string',
            'color' => 'required|integer',
            'Repeat' =>'required|string',
            //'status' => 'boolean',
        ]);

        // Check if validation fails
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 400);
        }

        $user = Auth::user();
         // Check if the user is authorized to perform the action
         if (!$user) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        // Get the validated data
        $validatedData = $validator->validated();

        try {
            // Create the event
            $event = Event::create($validatedData);

            // Return success response with the created event
            return response()->json(['success' => 'Event added successfully', 'event' => $event], 201);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Event creation failed', 'message' => $e->getMessage()], 500);
        }
    }
    
    public function getEventsByUserId($userId)
    {
        try {
            $events = Event::where('user_id', $userId)->get();
            return response()->json($events, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Could not retrieve events'], 500);
        }
    }

    public function show($id)
    {
        try {
            $event = Event::findOrFail($id);
            return response()->json($event, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Event not found'], 404);
        }
    }

    public function update(Request $request, $id)
    {
        // Validate the request data
        $validator = Validator::make($request->all(), [
            'user_id' => 'required',
            'title' => 'required|string|max:255',
            'note' => 'nullable|string',
            'date'=>'required',
            'start_time' => 'required',
            'end_time' => 'required',
            'Remind' => 'required|string',
            'color' => 'required|integer',
            'Repeat' =>'required|string',
            'status' => 'boolean',
        ]);

        // Check if validation fails
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 400);
        }

        $user = Auth::user();
        // Check if the user is authorized to perform the action
        if (!$user) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        try {
            // Find the event by ID
            $event = Event::findOrFail($id);

            // Get the validated data
            $validatedData = $validator->validated();

            // Update the event with validated data
            $event->update($validatedData);

            // Return success response with the updated event
            return response()->json(['success' => 'Event updated successfully', 'event' => $event], 200);
        } catch (\Exception $e) {
            // Return error response if something goes wrong
            return response()->json(['error' => 'Event update failed', 'message' => $e->getMessage()], 500);
        }
    }

    public function destroy($id)
    {
        $user = Auth::user();
        // Check if the user is authorized to perform the action
        if (!$user) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        try {
            // Find the event by ID
            $event = Event::findOrFail($id);
            $event->delete();
            return response()->json(['message' => 'Event deleted successfully'], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Event deletion failed', 'message' => $e->getMessage()], 500);
        }
    }
}
