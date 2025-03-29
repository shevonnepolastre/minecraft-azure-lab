## OptiFine Compatibility with Minecraft 1.21.5

### Issue

After upgrading to Minecraft 1.21.5, I encountered an error with OptiFine saying it's incompatible or not installed, even though I'm running the correct version of Minecraft.

**Root Cause:** OptiFine is very version-specific and does not yet officially support Minecraft 1.21.5 at the time of writing. You must use the exact version OptiFine is built for.

---

### Workaround Options

#### Option 1: Wait for OptiFine 1.21.5 Release
- Check the [OptiFine Downloads Page](https://optifine.net/downloads) for updates.
- Look under the Preview Versions section if you don’t see a stable release.
- Once it’s available, download and install it like normal.

#### Option 2: Downgrade to a Compatible Minecraft Version
If you want to use OptiFine right away:

1. Open the Minecraft Launcher.
2. Go to `Installations > New Installation`.
3. Choose an older supported version (such as 1.21.4 or 1.20.1).
4. Save and launch.
5. Download the matching version of OptiFine from: [https://optifine.net/downloads](https://optifine.net/downloads)
6. Run the `.jar` installer and select Install.

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
- [Lithium (game optimizations)](https://modrinth.com/mod/lithium)
- [FerriteCore (memory optimizations)](https://modrinth.com/mod/ferrite-core)

Then, launch Minecraft using the Fabric profile.

---

### Summary

| Option                | Use If...                               |
|-----------------------|------------------------------------------|
| OptiFine 1.21.5       | You are willing to wait for official support |
| Downgrade to 1.21.4   | You need OptiFine immediately           |
| Fabric + Sodium/Iris  | You want a fast, modern alternative now |
