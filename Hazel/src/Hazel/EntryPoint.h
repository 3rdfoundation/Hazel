#pragma once

#ifdef HZ_PLATFORM_WINDOWS

// Class implementing engine defines this (ex:Sandbox)
extern Hazel::Application* Hazel::CreateApplication();

int main(int argc, char** argv) {

	printf("===================================================================\n");
	printf("Hazel Engine Starting\n");
	printf("===================================================================\n");

	// Get a handle to the external subclass of our engine
	auto app = Hazel::CreateApplication();

	// Start the engine
	app->Run();

	// Engine cleanup
	delete app;
}

#endif