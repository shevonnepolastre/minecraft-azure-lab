# Minecraft Server Setup on Azure

This guide documents the steps I took to create a Minecraft server as part of my hands-on learning for the AZ-104 certification. It includes setup instructions, issues faced, and how I resolved them.

---
## 🔧 Setup Steps

### 0. Add Azure Credentials and Linux VM Passwords as GitHub Secret
You can use this [guide](https://github.com/shevonnepolastre/minecraft-azure-lab/blob/main/docs/add-azure-secret-to-github.md) I created 
### 1. **Provision Azure Virtual Machine**
- **Image Used**: Ubuntu 22.04 LTS
- **Size**: Standard B2s (2 vCPU, 4 GB RAM)
- **Region**: East US
- **Authentication**: SSH Public Key
- **Ports Opened**: 22 (SSH), 25565 (Java), 19132 (Bedrock)

This was done using [Bicep](https://github.com/shevonnepolastre/minecraft-azure-lab/blob/main/infrastructure/compute.bicep) and [GitHub Actions](https://github.com/shevonnepolastre/minecraft-azure-lab/blob/main/yaml-files/deploy-linux-vm.md)

### 2. Install Java

After the VM gets configured, SSH to connect to the VM and install [Java](https://github.com/shevonnepolastre/minecraft-azure-lab/blob/main/docs/updating%20to%20java%2021%20sdk.md)

### 3. Install Minecraft Server file

The extension is ".jar" and you will want to use 

```bash
wget [Minecraft jar link]
```

Then mark the agreement file called "EULA" to true

I had issues with my login cause in Azure you have your login and then you have the VM login.  After resolving that and using the VM Admin, I used this command to do it:

```bash

echo "eula=true" > eula.txt
```

You can also use nano by using:

```bash
nano eula.txt
```

### 4. Launch the Server

```bash

java -Xmx1024M -Xms1024M -jar server.jar nogui

```
BUT if you are using something like Fabric or Optifine, you would actually launch the server using this command:

```bash
java -Xmx2G -Xms1G -jar fabric-server-launch.jar nogui

```

It's the same if you launch it on the client side.  You will have different profiles. It's the same on the server.  

### 5. Install Optifine or Fabric to add Mods and Shader Packs 

You can find some [details here](https://github.com/shevonnepolastre/minecraft-azure-lab/blob/main/docs/installing-shader-packs.md).

### 6. Install Geyser MC for Cross Playing with Bedrock Players

Guide [here](https://github.com/shevonnepolastre/minecraft-azure-lab/blob/main/docs/bedrock-support.md). 

I installed the Fabric mod.  However, there is a standalone version.  I tried the standalone, but the only thing is that when you restart the VM again, you have to restart Geyser separately, and then it has to be on a separate terminal screen.  It's a small inconvenience, but I prefer launching everything all at once. 


