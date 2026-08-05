include .env

REQUIRED_REFERENCES = Assembly-CSharp.dll UnityEngine.UI.dll
VERSION = $(shell awk 'NR==7{print $2}' ./Plugin/UltrawidePlugin.csproj | xargs | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')

build-deploy: build deploy

build:
	$(if $(wildcard References/),,"${MAKE}" init)
	@dotnet build ./Plugin/UltrawidePlugin.csproj

deploy:
	@yes | cp "Plugin/bin/Debug/netstandard2.1/UltraWidePlugin.dll" "${GAME_PATH}/BepInEx/plugins/UltraWidePlugin.dll"
	@echo "Copied built DLL to ${GAME_PATH}/BepInEx/plugins/"

restore:
	@dotnet restore ./Plugin/UltrawidePlugin.csproj

init:
	@mkdir -p References
	@for r in ${REQUIRED_REFERENCES}; do \
		yes | cp "${GAME_PATH}/Rubinite_Data/Managed/$$r" References/; \
	done
	@echo "Copied required reference DLLs from ${GAME_PATH}/Rubinite_Data/Managed/ to workspace"

clean:
	@dotnet clean ./Plugin/UltrawidePlugin.csproj
	@rm -rf References

.PHONY: release
release: clean init build
	@mkdir -p Release/BepInEx/plugins/
	@cp "Plugin/bin/Debug/netstandard2.1/UltraWidePlugin.dll" "Release/BepInEx/plugins/"
	@zip -D -j -r Release/UltrawideFix.${VERSION}.zip Release/BepInEx/
	@rm -rf Release/BepInEx/
	@echo "New release archive available at Release/UltrawideFix.${VERSION}.zip"
