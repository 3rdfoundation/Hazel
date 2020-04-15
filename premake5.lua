workspace "Hazel"
	architecture "x64"

	configurations {
		"Debug",
		"Release",
		"Dist"
	}

-- this uses tokens (see premake wiki for a list of them)
--  cfg.buildcfg (Debug/Release/Dist)
--  cfg.system (Windows/Mac/Linux)
--  cfg.architecture (x64)
outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "Hazel"
	location "Hazel"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "hzpch.h"
	pchsource "Hazel/src/hzpch.cpp"

	files {
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs {
	    "%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include"
	}

	-- FYI: Windows SDK version from properties = 10.0.15063.0
	filter "system:windows"
		-- cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		-- ommitted: HZ_BUILD_DLL
		defines {
			"_SCL_SECURE_NO_WARNINGS",
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL"
		}

		postbuildcommands {

			-- Copy Hazel.dll into Sandbox
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "HZ_DIST"
		optimize "On"

	-- MT = multi-threaded runtime library
	-- filters { "system:windows", "configurations:Release" }
	-- 	buildoptions "/MT"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files {
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs {
		"Hazel/vendor/spdlog/include",
		"Hazel/src"

	}

	links {
		"Hazel"
	}

	-- FYI: Windows SDK version from properties = 10.0.15063.0
	filter "system:windows"
		--cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		-- ommitted: HZ_BUILD_DLL
		defines {
			"_SCL_SECURE_NO_WARNINGS",
			"HZ_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "HZ_DIST"
		optimize "On"