function startMusic(_song){
	// If this is a different song then start up the new one and fade in.
	if ( global.song != _song ){
		//Failsafe to stop all audio 
		audio_stop_all();
		//Start new song
		global.song_id = audio_play_sound(_song,1,true,0.001);
		global.song = _song;
	}
	audio_sound_gain(global.song_id, 1, 6000);
}

function stopMusic(){
	audio_stop_sound(global.song_id);
}

function fadeMusic(){
	audio_sound_gain(global.song_id, 0, 1000);	
}