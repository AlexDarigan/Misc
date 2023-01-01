#pragma once
#include <iostream>
#include <string>
#include <array>

class Song {

public:
	std::string title;
	std::string artist;
	double duration = 0.0;
	 
	Song(std::string _title, std::string _artist, std::string _duration) {
		title = _title;
		artist = _artist;
		duration = atof(_duration.c_str());
	}

	~Song() { }

	void play() {
		printf("Playing '%s' by '%s' for '%.2f' minutes", title.c_str(), artist.c_str(), duration);
	}

	void display() {
		printf("(%s, %s, %.2f) ", title.c_str(), artist.c_str(), duration);
	}

};
