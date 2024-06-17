<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Event extends Model
{
    protected $primaryKey = 'event_id'; // Specify the custom primary key

    /**
     *    $table->increments('event_id');
            $table->unsignedInteger('user_id');
            $table->string('title');
            $table->text('note')->nullable();
            $table->date('date');
            $table->string('start_time');
            $table->string('end_time')->nullable();
            $table->string("Remind")->nullable();
            $table->string("Repeat")->nullable();
            $table->boolean('status')->default(false); // fo
     */
    protected $fillable = [
        'user_id',
        'title',
        'note',
        'date',
        'start_time',
        'end_time',
        'Remind',
        'Repeat',
        'color',
        'status',
    ];

     /**
     * Define a relationship between the Event and User models.
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Define a relationship between the Event and Reminder models.
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     * 
     * In the context of the Event model you provided, the hasMany relationship 
     * is used to define that one event can have multiple reminders associated with it. 
     * If your application does not require managing reminders for events, you might not need this relationship.
     */
    // public function reminders()
    // {
    //     return $this->hasMany(Reminder::class);
    // }
}
