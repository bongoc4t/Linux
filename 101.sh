# Let's start saying that this is a compilation of commands that i used and learned.
# I use this in RHEL, CentOS and Fedora.

#-USE SYSTEM DOCUMENTATION-#
info #Read information files; provides more information than man
whoami #print the name of the current user
which #Show full path of command; useful for scripting
whatis #Display manual page descriptions
locate #Locate files on system by name
uptime #shows since how long your system is running and the number of users are currently logged in and also displays load average for 1,5 and 15 minutes intervals.
W #It will displays users currently logged in and their process along-with shows load averages. also shows the login name, tty name, remote host, login time, idle time, JCPU, PCPU, command and processes.
updatedb #Update locate command databases
man #Documentation, 9 sections
    1 #Executable programs and shell commands
    2 #System calls
    3 #Library calls
    4 #Special files
    5 #File formats
    6 #Games
    7 #Miscellaneous
    8 #root user commands
    9 #Kernel routines

#-BOOT, REBOOT AND SHUTDOWN-#
-Reboot:
    reboot
    systemctl reboot
    shutdown -r now
-Shutdown:
    systemctl halt
    halt
    hutdown -h now
    init 0
-Power off:
    systemctl poweroff
    poweroff
    shutdown -P

#-CRONTAB-#
30 08 10 06 * /home/maverick/full-backup
•	Minute – A minute value can be between 0-59
•	Hour – A hour value can be between 0-23
•	Day_of_the_month – This value can between 1-31. For the months having less days will ignore remaining part
•	Month_of_the_year – This can be between 1-12. You can also define this value with first three alphebts of month like jan, feb, mar, apr etc.
•	Day_of_the_Week – This can be the value between 0-7. Where 0 and 7 for Sunday, 1 for Monday, 2 for Tuestday etc. You can also use first three alphabets of days like, sun, mon, tue, wed, etc.
•	command/script to execute

#-BASIC LINUX COMMANDS-#
#---->if you need to see the options remember to add -h or -help
pwd #Show current working directory path
cd  #Change directory
ls #List contents of directory
sudo #Allows a super user to run a command with root priviledges
mkdir #Create new directory
rmdir #Remove directory
rm -rf #Force remove a directory, recursively (includes all files inside)
touch #Create new, empty files
echo "test" > file.txt #Redirect standard output to file
echo "test" >> file.txt #Replaces file, if already exists
2> #Redirect standard error
2>> #Redirect and append standard error
/dev/null #Data sent to /dev/null is lost
2>&1 #Redirect STDEDD to STDOUT
less #File viewing application and STDOUT can often piped into for ease of reading
head #Show first ten lines of file, with -n  Define number of lines
tail #Show last ten lines of file, with -n • Define number of lines
su USER #switch to USER user (non-login shell)
su - USER #Login into a login shell
yum install PACKAGENAME
yum update PACKAGENAME
yum list kernel #list installed and available kernels
history #displays the summary of the commands


#-CREATION OF FILES AND FOLDERS-#
#---->if you need to see the options remember to add -h or -help
mkdir #Make directory
cp #Copy files and directories
mv #Move files and directories
rm #Remove files and directories
ln #Create links between files. Links directly to an inode to create a new entry referencing an existing file on the system
ln -s #Soft links that connects one file to another, symbolically

#-SETUP ALIAS-#
alias #list all aliases
1- vim ~/.bash_aliases OR ~/.bashrc #in superuser mode open with VIM or any other text editor like NANO, try with both directions
2- find the part of "#My custom aliases" and add your aliases
3- save the document and exit
4- source ~/.bashrc OR ~/.bash_aliases #to activate it, or just close the terminal and open a new one


#-CHANGE PERMISSIONS-#
r/4 - read
w/2 - write
x/1 - execute

chmod #set the permissions for a file or directory
    -u #User
    -g #Group
    -o #Other
    -a #All
    -r #Read
    -w #Write
    -x #Execute
    -s #Set UID or GID
    -t #Set sticky bit
chown #Change owner and group permissions
    -R #Set ownership recursively
chgrp #Change group ownership
umask #Set default permissions for new directories and files


#-GREP AND REGULAR EXPRESSIONS-#
#---->if you need to see the options remember to add -h or -help
grep #Prints lines that match defined pattern
- grep "PATTERN" file.txt
#check this site for more info: 
#https://www.tecmint.com/12-practical-examples-of-linux-grep-command/


#-REMOTE ACCESS AND SWITCH USERS-#
sudo vim /etc/ssh/sshd_config #for the edition of the SSH config file
sudo ssh service <restart/start/stop> #restart, start or stop the service
ssh user@SERVER #Connect to remote host
ssh-keygen -t rsa #will generate a public/private rsa key pair
ssh-copy-id SERVER/HOST #To copy your key to a server
scp fileName user@SERVER:/home/username/destination #securely copy files over the SSH protocol using the SCP tool
ssh -D 8888 user@remoteserver # The ssh client can tunnel traffic over the connection using a SOCKS proxy server with a quick one liner. A key thing to understand is that traffic to the remote systems will have a source of the remote server.
ssh -v -R 0.0.0.0:1999:127.0.0.1:902 192.168.1.100 user@SERVER #SSH REVERSE TUNNEL - With this ssh session established a connection to the remoteserver port 1999 will be forwarded to port 902 on our local client
ssh -v -R 0.0.0.0:1999 192.168.1.100 user@SERVER #SSH REVERSE PROXY


#-COMPRESSION USING TAR,GZIP OR BZIP2-#
tar #Archive files; does not handle compression
    -c #Create new archive
    -t #List contents of archive
    -x #Extract files from archive
    -z #Compress or uncompress file in gzip
    -v #Verbose
    -j #Compress or uncompress file in bzip2
    -f #Read archive from or to file

star #Archiving utility generally used to archive large sets of data; includes pattern-matching and searching
    -c #Create archive file
    -v #Verbose output
    -n #Show results of running command, without executing the actions
    -t #List contents of file
    -x #Extract file
    --diff #Show difference between files
    -C #Change to specified directory
    -f #Specify file name

gzip #Compression utility used to reduce file sized; files are unavailable until unpacked; generally used with tar
    -d #Decompress files
    -l #List compression information


#-CPU/MEMORY COMMANDS-#
Ps #displays processes running in the system
Kill #terminate process
   pkill -9 -t [pts/tty#] #kill user session
•	TTY: tty stands for Teletypewriter. This is directly connected to the system as a keyboard/mouse or a serial connection to the device (for instance, the console on your system).
•	PTS: pts Stands for the pseudo terminal slave. It is a terminal device, which is emulated by another program (for instance, ssh session to your system).
top
    k #Kill process
    q #Quit
    r #Renice
    s #Change update rate
    P #Sort by CPU usage
    M #Sort by memory usage
    l #Toggle load average
    t #Toggle task display
    m #Toggle memory display
    B #Bold display
    u #Filter by username
    -b #Start in batch mode
    -n #Number of updates before exiting
pgrep #Search processes
    -u #Username
    -l #Display process name
    -t #Define tty ID
    -n #Sort by newest
pkill #Kill process
    -u #Kill process for defined user
    -t #Kill process for defined terminal