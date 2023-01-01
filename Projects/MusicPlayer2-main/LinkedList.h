#pragma once
#include "Node.h"
#include <iostream>
#include <typeinfo>
#include "Filters.h"

template <class T>
class LinkedList {

private:

	Node<T> *head = nullptr;
	Node<T> *tail = nullptr;
	int count = 0;

protected:

	void add(Node<T>* next) {
		if (head == nullptr) {
			head = next;
			tail = next;
		}
		else {
			tail->next = next;
			next->prev = tail;
			tail = next;
		}
		count++;
	}

	void addSorted(T* data, bool(*sortBy)(T* a, T* b)) {
		Node<T>* node = new Node<T>(data);

		if (head == nullptr) {
			head = node;
			tail = node;
			return;
		}

		Node<T>* current = head;
		while (current->next != nullptr && sortBy(current->data, node->data)) {
			current = current->next;
		}

		if (current->next == nullptr) {
			node->prev = tail;
			tail->next = node;
			tail = node;
		} else {
			node->prev = current;
			current->next = node; // we lost next
		}

		count++;
	}

	template <class C>
	Node<T>* Find(C criteria, bool (*findBy)(C, T*)) {
		Node<T>* current = head;
		while (current != nullptr) {
			if (findBy(criteria, current->data)) {
				return current;
			}
			current = current->next;
		}
		return nullptr;
	}

	void remove(Node<T>* node) {
		// The caller is responsible for finding this node in the first place..
		// ..so it must exist before this method is called
		if (node == head && node == tail) {
			head = nullptr;
			tail = nullptr;
		} else if (node == head) {
			head = head->next;
			head->prev = nullptr;
		} else if (node == tail) {
			tail->prev->next = nullptr;
			tail = tail->prev;
		} else {
			node->next->prev = node->prev;
			node->prev->next = node->next;
		}
		delete node;
		count--;
	}

public:
	LinkedList<T>() {}
	~LinkedList() { }

	void add(T* data) {
		Node<T>* node = new Node<T>(data);
		add(node);
	}

	T* get(int index) {
		if (index < 0 || index >= count) { return nullptr; }

		Node<T>* current = head;
		for (int i = index; i < index; i++) { current = current->next; }
		return current->data;
	}

	T* getRandom() { return(get(rand() % count)); }

	template <class C>
	LinkedList<T>* filter(C criteria, bool (*filterBy)(C, T)) { 
		LinkedList<T> *list = new LinkedList<T>();
		Node<T>* current = head;
		while (current != nullptr) {
			// Note: If this is the library, then we are already sorted
			if (filterBy(criteria, current->data)) 
			{
				// Because this is a new list, we need to create a new set of nodes in order..
				// to preserve next/previous relationships
				list->Add(new Node<T>(current->data)); 
			}
			current = current->next;
		}
		return list;
	}

	void forEach(void (*func)(T*)) {
		Node<T>* current = head;
		while (current != nullptr) {
			func(current->data);
			current = current->next;
		}
	}

	void addNewSong() {
		std::string title = prompt("Enter title");
		std::string artist = prompt("Enter artist");
		std::string duration = prompt("Enter duration");
		Song* song = new Song(title, artist, duration);
		song->display();
	}

	void play() {
		Song* song = findSong();
		if (song != nullptr) { song->play(); }
	}

	Song* findSong() {
		std::string title = prompt("Enter Song Title");
		Node<Song>* node = Find(title, hasTitle);
		if (node != nullptr) { return node->data; }
		printf("Could not find Song '%s'", title.c_str());
		return nullptr;
	}

	void removeSong() {
		std::string title = prompt("Enter Song Title");
		Node<Song>* node = Find(title, hasTitle);
		if (node == nullptr) {
			printf("%s does not exist in Library", title.c_str());
		}
		else {
			remove(node);
			printf("Removed %s from Library", title.c_str());
		}
	}
};

