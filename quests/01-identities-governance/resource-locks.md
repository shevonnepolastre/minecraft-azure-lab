# Resource Locks to Consider

Microsoft doesn't have best practices on using resource locks so you really need to consider which ones make sense, including if sometimes it's better to have a policy. For my Minecraft setup, I decided that I definitely need a delete resource lock on the virtual machine.  I chose this over Read-Only because I sometimes change worlds, and to do that you have to make modifications so it spawns a new world.  I found this great [Reddit thread]( https://www.reddit.com/r/AZURE/comments/16ddjms/best_practice_for_resource_locks/) on what others are doing. 

Another resource lock that I plan to create will be for the storage account that I plan to create and use to backup my worlds.  I am currently thinking that one will be read-only but that might change.

![image](https://github.com/user-attachments/assets/4e819ef8-0b1f-42eb-b7aa-8f038fb33f45)
