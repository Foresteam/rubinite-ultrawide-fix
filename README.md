# UltrawideFix for Rubinite

A BepInEx plugin that adds support for common ultrawide resolutions and adjusts UI elements to prevent rendering outside of the visible space.

## Requirements

- [BepInEx](https://github.com/BepInEx/BepInEx/releases) - Install BepInEx for Rubinite following the [official documentation](https://docs.bepinex.dev/articles/user_guide/installation/index.html)

## Installation

1. Download the latest release from [Releases](../../releases)
2. Extract the contents of the zip file
3. Place the extracted `BepInEx` folder in your Rubinite game directory:
   ```
   .../Steam/steamapps/common/Rubinite/
   ```

## Building from Source

### Prerequisites

- [.NET SDK](https://dotnet.microsoft.com/download) (version 6.0 or higher)
- Rubinite game installed with BepInEx

### Steps

Setup .env with your game path then run 
```bash
make
```

This does the following:

1. Restore dependencies:

```bash
make restore
```

2. Initialize references:

```bash
make init
```

This copies the required game DLLs from `Rubinite_Data/Managed/` to the `References/` folder.

3. Build the project:

```bash
make build
```

4. Deploy to game directory:

```bash
make deploy
```


