# SaintsRow2-Proton-Fixer
A set of scripts that allow the user to run Saints Row 2 a little better.

# What does it do?
The performance on the PC port of Saints Row 2 is terrible. Without any tweaks my RTX 2080 couldn't push more than 30FPS on high setings. These scripts apply fixes that should boost play-ability.

The main script applies the following fixes:
1. Forces the game to use Vulkan, instead of DirectX9. This allows for more stable frame rates, even on Windows. (For Saints Row 2)

It also creates a custom config file for Vulkan with specific tweaks, such as capping the game at 60 FPS, which will allow the game to run that bit smoother.

Aside from the main script I have also created two additional scripts for your convenience. These are:
* **resolution_changer.sh** - Fixes issues with setting resolutions in game, but can also be used to force the game to render resolutions that aren't natively supported. This allows the game to be more acessible to ultra-wide monitor users or anyone else that has an abnormal resolution.
* **audio_fixer.sh** - Fixes an issue in which audio not play after switching Proton versions. [requires winetricks]

# How to use
Run the script from the terminal, and it will automatically do everything.
* Example: `./saintsrow2_fixer.sh`

For a more detailed guide, on how to use all of the scripts, please refer to the 'help.txt' documentation. It goes more in-depth than I could here on GitHub.

# Before you use
You want to use my script? Brilliant! Before you download, I will tell you that this script does automatically download files that are needed to ensure the script does its job. 

These files are as follows:
1. DXVK - Which allows the script to force the game to use Vulkan. This is vital to ensuring a smooth game play experience.


The link to this file will be below, along with a VirusTotal scan. If you're still worried about these links, that is understandable; but these are required to give the best experience.

* DXVK GitHub Page: https://github.com/doitsujin/dxvk
* DXVK VirusTotal Scan: https://www.virustotal.com/gui/file/8d1a3c912761b450c879f98478ae64f6f6639e40ce6848170a0f6b8596fd53c6

If you still have any concerns, please do not use the script.

# Need help or have a bug to report?
If you need help, and you cannot find the solution in the 'help.txt' document, feel free to message me and I will be happy to help! Same goes for any bug reports.

# Forking My Projects?

All of my projects you can fork and utilise the code however you want. You don't need to give me credit, but can do if you would like.
