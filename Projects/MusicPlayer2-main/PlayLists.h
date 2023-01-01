#pragma once
#include <string>
#include <map>
#include "LinkedList.h"

class PlayLists {

private:
	std::map<std::string, LinkedList<Song>*> lists;

public:
	PlayLists() {
		lists["default"] = new LinkedList<Song>();
	}

	~PlayLists() {}

	void createPlaylist() {
		std::string name = prompt("Enter new playlist name");
		lists[name] = new LinkedList<Song>();
		printf("Created playlist '%s'", name.c_str());
	}

	void addFromLibrary(LinkedList<Song> *library) {
		Song *song = library->findSong();
		if (song == nullptr) { return; }
		std::string playlist = prompt("Enter playlist name");
		if (lists.contains(playlist)) {
			lists[playlist]->add(song);
		} else {
			printf("Playlist '%s' does not exist\n", playlist.c_str());
		}
	}

	void play() {
		std::string name = prompt("Enter playlist name");
		if (lists.contains(name)) {
			lists[name]->forEach(playSong);
		}
	}

	void removeFromPlayList() {
		std::string name = prompt("Enter playlist name");
		if (lists.contains(name)) {
			lists[name]->removeSong();
		} else {
			printf("Playlist '%s' does not exist\n", name.c_str());
		}
	}

	void printPlaylistNames() {
		for (auto const& [key, val] : lists) {
			std::cout << key << ", ";
		}
		std::cout << std::endl;
	}
	
};
