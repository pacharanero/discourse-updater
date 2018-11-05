# Multiple Discourse Updater script

This script simplifies the job of updating multiple Discourse instances on Ubuntu Server.
It also updates the server OS for you and remembers to do things like autoclean and autoremove.
Instead of using the graphical updater inside Discourse, this script uses the command line.

## How It Works
This script uses your SSH config to log into each of your Discourse instances and sends a Bash script there, which is run on the remote machine. You can (and should) have a look at the Bash script source code, to see what it's doing, but basically this it's what's happening:
* updates the Ubuntu Server OS itself - using `apt update`, `apt dist-upgrade` etc
* performs `apt autoremove` and `apt autoclean`
* `cd`s into your /var/discourse directory
* `git pull`s then does a `./launcher update app`
* cleans up unused containers to save space on your server
* Deliberately, these updates are done sequentially, not concurrently, this is so that if there is any problem with the update, you can stop the process.

## Prerequisites
* Prerequisites are pretty much the same as for Discourse itself - you need `git` and `apt` to be installed
* Designed for Ubuntu Server but should work on other distros with apt available, and should be easy to modify for other package managers.
* you need an `.ssh/config` file and it should have all the details in there to enable securely logging in, and the login should allow passwordless sudo. If you are already managing a number of Discourse instances via SSH you may already have them set up in your SSH config file.

# USAGE
* Tell the script what all your Discourse instances are called in your SSH config, by editing `discourses-template.yml` and renaming it `discourses.yml` to activate it
* type `discourse-updater <discourse name>` to update that Discourse instance.
* or type `discourse-updater all` to update **all** your Discourse instances, in the order they are listed in `discourses.yml`



## SECURITY
* NEVER check your private SSH keys into a Git repo!!!! - keep them in `.ssh/ on a secure local machine`
* I strongly advise not to check your SSH `config` file into version control either - it's less of an issue than the actual keys, but it may assist an attacker to know that a server is a Discourse server (eg if there was a known vulnerability)
* Similarly, it's advisable to keep your `discourses.yml` out of version control, for similar reasons, although since the servers are only referenced by the (arbitrary) name you have given them in your SSH config, this is less useful to a would-be attacker.

## What is an SSH Config?
SSH config allows you to create setups for each of the machines you access using SSH:

``# My Live Discourse`                        <--- comment line
`Host            mydiscourse`                 <--- this is the name you need to list in discourses.yml
`HostName        discourse.digitalhealth.net` <--- this can be an IP or a domain name
`User            someusername`                <--- this is the username that you will log in as (eg 'ubuntu', or 'root' if you're not security conscious)
`IdentityFile    ~/.ssh/mydiscourses_id_rsa`  <--- this is the path (on your local machine) to your SSH Key for that Discourse instance

## DONATIONS
* If this script has been of use to you, please consider buying me a coffee or a beer using this link https://paypal.me/pacharanero

## LICENSE
* GNU GPL v3 just like Discourse itself.

## CONTRIBUTING
I welcome contributions of all kinds and will endeavour to solve issues and merge PRs where possible.
* Feel free to create Issues in the Issues section.
* To develop and contribute code:
* Fork this repo to your own GitHub account.
* Make your changes & commit them.
* Submit a PR to this repo explaining the reason for the changes and why I should include them.
