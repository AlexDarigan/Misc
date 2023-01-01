#pragma once
#include "Song.h"

static bool hasTitle(std::string title, Song* song) {
	return song->title.compare(title) == 0;
}

static bool hasArtist(std::string artist, Song* song) {
	return song->artist.compare(artist) == 0;
}

static bool sortBy(Song* a, Song* b) {
	return a->title.compare(b->title) < 0;
}

static void printSong(Song* song) {
	song->display();
}

static void playSong(Song* song) {
	song->play();
}
