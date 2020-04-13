#include <Hazel.h>

class Sandbox : public Hazel::Application {

public:

	Sandbox() {
	}

	~Sandbox() {
	}

};

// Static bootstrap to allow the hazel engine to get a handle to this subclass implementation
Hazel::Application* Hazel::CreateApplication() {
	return new Sandbox();
}