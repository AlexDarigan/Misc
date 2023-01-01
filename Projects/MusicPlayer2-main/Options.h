#pragma once
#include <iostream>

enum Options {
    Exit = 0, AddSongToLibrary, FindSongInLibrary, PlayASongFromTheLibrary, RemoveSongFromLibrary,
    CreateAPlaylist, AddSongToPlaylist, PlayPlaylist, RemoveSongFromPlaylist, DisplayMusicLibrary
};

void displayMenu() {
    std::cout << "Please select a valid option\n"
    << "0. Quit the Application\n"
    << "1. Add a new Song to the Library\n"
    << "2. Find a Song in the Library\n"
    << "3. Play a Song from the Library\n"
    << "4. Remove a Song from the Library\n"
    << "5. Create a Playlist\n"
    << "6. Add a Song to a Playlist\n"
    << "7. Play a Playlist\n"
    << "8. Remove a Song from a Playlist\n"
    << "9. Display Music Library\n";
}