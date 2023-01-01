#include <iostream>
#include <filesystem>
#include <fstream>
#include <conio.h>
#include "Options.h"
#include "Input.h"
#include "Song.h"
#include "Node.h"
#include "Playlists.h"

LinkedList<Song>* loadLibrary(std::string directory) {
	LinkedList<Song> *library = new LinkedList<Song>();
	for (const auto& entry : std::filesystem::directory_iterator(directory)) {
		std::ifstream file(entry.path());
		std::string title, artist, duration;
		std::getline(file, title);
		std::getline(file, artist);
		std::getline(file, duration);
		Song* song = new Song(title, artist, duration);
		library->add(song);
	}
	return library;
}

int main() {
	LinkedList<Song> *library = loadLibrary(".\\MusicLibrary");
	PlayLists *playLists = new PlayLists();
	bool running = true;
	while (running) {
		displayMenu();
		int option = getSelectedOption();
		switch (option) {
		case Exit:
			running = false;
			break;
		case AddSongToLibrary:
			library->addNewSong();
			break;
		case FindSongInLibrary: {
				Song *song = library->findSong();
				if (song != nullptr) { song->display(); }
			}
			break;
		case PlayASongFromTheLibrary:
			library->play();
			break;
		case RemoveSongFromLibrary:
			library->removeSong();
			break;
		case CreateAPlaylist:
			playLists->createPlaylist();
			break;
		case AddSongToPlaylist:
			playLists->addFromLibrary(library);
			break;
		case PlayPlaylist:
			playLists->play();
			break;
		case RemoveSongFromPlaylist:
			playLists->removeFromPlayList();
			break;
		case DisplayMusicLibrary:
			library->forEach(printSong);
			break;
		default:
			break;
		}
		if (option != 0) { waitForContinueKey(); }
	}
}
