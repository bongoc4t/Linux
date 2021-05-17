#-FILE SYSTEM HIERARCHY-#
/etc #Contains configuration files for programs and packages
    /etc/passwd #contains passwords and other information concerning users who are registered to use the system. For obvious security reasons, this is writable only by root and readble by others. It can be modified by root directly, but it is preferable to use a configuration utility such as passwd to make the changes. A corrupt /etc/passwd file can easily render a Linux box unusable.  
        
        1-Username: It is used when user logs in. It should be between 1 and 32 characters in length.
        2-Password: An x character indicates that encrypted password is stored in /etc/shadow file. Please note that you need to use the passwd command to computes the hash of a password typed at the CLI or to store/update the hash of the password in /etc/shadow file.
        3-User ID (UID): Each user must be assigned a user ID (UID). UID 0 (zero) is reserved for root and UIDs 1-99 are reserved for other predefined accounts. Further UID 100-999 are reserved by system for administrative and system accounts/groups.
        4-Group ID (GID): The primary group ID (stored in /etc/group file)
        5-User ID Info: The comment field. It allow you to add extra information about the users such as user’s full name, phone number etc. This field use by finger command.
        6-Home directory: The absolute path to the directory the user will be in when they log in. If this directory does not exists then users directory becomes /
        7-Command/shell: The absolute path of a command or shell (/bin/bash). Typically, this is a shell. Please note that it does not have to be a shell. For example, sysadmin can use the nologin shell, which acts as a replacement shell for the user accounts. If shell set to /sbin/nologin and the user tries to log in to the Linux system directly, the /sbin/nologin shell closes the connection.

    /etc/group #similar to /etc/passwd but for groups
    /etc/hosts #contains a list of host names and absolute IP addresses.
    /etc/resolv.conf #contains a list of domain name servers used by the local machine
    /etc/aliases #file containing aliases used by sendmail and other MTAs (mail transport agents).
    /etc/bashrc #system-wide default functions and aliases for the bash shell
    /etc/fstab #Information of Disk Drive and their mount point.
    /etc/conf.modules #aliases and options for configurable modules
    /etc/crontab #A shell script to run specified commands on a predefined time Interval.
    /etc/profile #Bash shell defaults
    /etc/profile.d #Application script, executed after login.
/var #Variable data specific to system. This data should not be removed or changed when the system reboots. Logs files tend to be stored within the /var directory
    /var/log/messages #general system messages/logs, includes most of what is in dmesg if it hasn’t “rolled over”.
    /var/log/dmesg  #boot time hardware detection and driver setup.
    /var/log/daemon.log #messages from service tasks like lircd
    /var/log/kern.log #if something has gone wrong with a kernel module, you may find something here.
/run #Runtime data for processes since last boot
/home #Location of home directories; used for storing personal documents and information on the system
/root #root user home directory
/tmp #Files are removed after ten days; universal read/write permissions
/boot #files needed to start the system boot process
/boot/vmlinuz #the typical location and name of the Linux kernel.
/dev #Contains information on essential devices
/dev/null #used when you want to send output into oblivion
/lib #Some shared library directories, files, and links
/mnt #The typical mount point for the user-mountable devices such as floppy drives and CDROM
/proc #Virtual file system that provides system statistics.  It doesn’t contain real files but provides an interface to runtime system information.
/sbin #Commands used by the super user for system administrative functions
/usr #Contains executable binaries, documentation, source code, libraries for second level program.
    /usr/bin #Contains commands available to normal users
    /usr/share #Contains shared directories for man files, info files, etc.
    /usr/lib #Library files searched by the linker when programs are compiled
    /usr/local/bin #Common executable application files local to this system
    /usr/sbin #Commands used by the super user for system administrative functions