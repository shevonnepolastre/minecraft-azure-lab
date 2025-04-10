## OptiFine Compatibility with Minecraft 1.21.5

### Issue

After upgrading to Minecraft 1.21.5, I encountered an error with OptiFine saying it's incompatible or not installed, even though I'm running the latest version of Minecraft.  It was the same thing when I tried to use shader packs with Fabric.  Therefore, I had to have two profiles -- 1.21.5 and 1.21.4.  

---

### Workaround Options

#### Option 1: Don't Play and Wait for OptiFine and Fabric to Upgrade to 1.21.5
- Look under the Preview Versions section if you don’t see a stable release.
- Once it’s available, download and install it like normal.

#### Option 2: Downgrade to a Compatible Minecraft Version
If you want to use one of them right away, then downgrade:

1. I decided to go this route with Fabric so now I have two versions.

---

### Alternative: Use Fabric with Sodium/Iris

If you want performance improvements or shaders without waiting on OptiFine, try this setup:

#### Install Fabric Mod Loader:
- Visit: [https://fabricmc.net/use/](https://fabricmc.net/use/)
- Download the installer and run it
- Choose your Minecraft version (for example, 1.21.5)

#### Add Performance Mods:
Download and place the following `.jar` files into your `~/.minecraft/mods` folder:

- [Sodium (performance)](https://modrinth.com/mod/sodium)
- [Iris (shaders)](https://modrinth.com/mod/iris)
- [Fabric](https://modrinth.com/mod/fabric-api) 

Then, launch Minecraft using the Fabric profile.  If you need to create a new one:
- Go to Installations and create a new profile 

