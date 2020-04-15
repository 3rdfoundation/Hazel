#pragma once

#ifdef HZ_PLATFORM_WINDOWS

// Class implementing engine defines this (ex:Sandbox)
extern Hazel::Application* Hazel::CreateApplication();

int main(int argc, char** argv) {

	// TODO: Per online training, this belongs somewhere else
	Hazel::Log::Init();
	HZ_INFO("===================================================================");
	HZ_INFO("Hazel Engine Starting");
	HZ_INFO("===================================================================");

	// example of logging a variable
	int a = 5;
	HZ_INFO("Var a={0}",a);

	// Get a handle to the external subclass of our engine
	auto app = Hazel::CreateApplication();

	// Start the engine
	app->Run();

	// Engine cleanup
	delete app;
}

#endif