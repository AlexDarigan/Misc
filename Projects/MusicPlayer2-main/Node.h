#pragma once

template <class T>
class Node {

public:
	Node* next = nullptr;
	Node* prev = nullptr;
	T* data = nullptr;

	Node(T* _data) { data = _data; }
	~Node() { }
};