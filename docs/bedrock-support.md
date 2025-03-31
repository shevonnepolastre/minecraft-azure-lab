## Ability to Cross Play with Bedrock Players 

In order to do this, I got the [Geyser MC mod](https://geysermc.org/wiki/geyser/setup/?host=provider). 

In Azure, you have to make sure you had a rule for Port 19132 in your NSG.  

After that, it's pretty simple.  

You have to install it on the server.  It didn't have a link to the file like the other mods, so I added it to my local computer and then copied it over to the server:

```bash

scp ~/Downloads/geyser-fabric-*.jar mcadmin@[enter your public IP here]:~/[If there is a folder minecraft is installed, type it here]/mods/

```

Geyster MC should be installed, and I was able to play with my preschooler while I was on the Java version and he was on his tablet on Bedrock.

### Lessons Learned

The next day I tried launching it and it wouldn't work.  I then tried installing the standalone version, but then I had to restart it separate from Minecraft because it didn't automatically start, and it's because I had stopped the VM. I realized I was using the wrong command to start Minecraft.  I had to use the command that included fabric, and not the standard one.  Even after launching it, I still couldn't get Bedrock to work.  I removed it after I realized my error, and it worked! 

Reminder to remove a directory in bash, you have to use recursive so:

```bash

rm -rf

```
