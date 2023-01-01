#pragma once
#include <iostream>
#include <string>

bool isInRange(int value, int low, int high) {
	return low <= value && value <= high;
}

void clearScreen() {
	system("cls"); // Windows only for now
}

std::string prompt(std::string message) {
	std::cout << message << std::endl << "> ";
	std::string input = "";
	std::getline(std::cin, input);
	return input;
}

void waitForContinueKey() {
	std::cout << "\nPress any key to continue\n> ";
	std::string _ = "";
	std::getline(std::cin, _);
	clearScreen();
}

int getSelectedOption() {
	std::string option = "-1";
	while (!isInRange(std::atoi(option.c_str()), 0, 9)) {
		std::cout << "> ";
		std::getline(std::cin, option);
	}
	clearScreen();
	return std::atoi(option.c_str());
}
