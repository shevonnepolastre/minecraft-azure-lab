## Ability to Cross Play with Bedrock Players 

In order to do this, I got the [Geyser MC mod](https://geysermc.org/wiki/geyser/setup/?host=provider). 

In Azure, you have to make sure you had a rule for Port 19132 in your NSG.  

After that, it's pretty simple.  

You have to install it on the server.  It didn't have a link to the file like the other mods, so I added it to my local computer and then copied it over to the server:

```bash

scp ~/Downloads/geyser-fabric-*.jar mcadmin@[enter your public IP here]:~/[If there is a folder minecraft is installed, type it here]/mods/

```

Geyster MC should be installed, and I was able to play with my preschooler while I was on the Java version and he was on his tablet on Bedrock.
