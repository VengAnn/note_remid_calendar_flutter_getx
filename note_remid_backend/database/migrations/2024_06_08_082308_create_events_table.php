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
        Schema::create('events', function (Blueprint $table) {
            $table->increments('event_id');
            $table->unsignedInteger('user_id');
            $table->string('title');
            $table->text('note')->nullable();
            $table->date('date');
            $table->string('start_time');
            $table->string('end_time')->nullable();
            $table->string("Remind")->nullable();
            $table->string("Repeat")->nullable();
            $table->integer('color');
            $table->boolean('status')->default(false); // for mean task completed (1) or not (0)
            $table->timestamps();

            // Define the foreign key constraint
            $table->foreign('user_id')->references('user_id')->on('users')->onDelete('cascade');
      });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('events');
    }
};
