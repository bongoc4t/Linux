#-ANALYSIS OF LOGS-#
•	Grep
#Using surround search returns a number of lines before or after a match. This provides context for each event by letting you trace the events that led up to or immediately followed the event. The -B flag specifies how many lines to return before the event, and the -A flag specifies the number of lines after.
#For example, let’s search for attempted logins with an invalid username and show the surrounding results. We see that users who fail to log in also fail the reverse mapping check. This means the client doesn’t have a valid reverse DNS record, which is common with public Internet connections. This doesn’t mean your SSH server is vulnerable, but it could mean attackers are actively trying to gain access to it.
#$ grep -B 3 -A 2 'Invalid user' /var/log/auth.log
#Apr 28 17:06:20 ip-172-31-11-241 sshd[12545]: reverse mapping checking getaddrinfo for 216-19-2-8.commspeed.net [216.19.2.8] failed - POSSIBLE BREAK-IN ATTEMPT!
#Apr 28 17:06:20 ip-172-31-11-241 sshd[12545]: Received disconnect from 216.19.2.8: 11: Bye Bye [preauth]
#pr 28 17:06:20 ip-172-31-11-241 sshd[12547]: Invalid user admin from 216.19.2.8
#pr 28 17:06:20 ip-172-31-11-241 sshd[12547]: input_userauth_request: invalid user admin [preauth]
#pr 28 17:06:20 ip-172-31-11-241 sshd[12547]: Received disconnect from 216.19.2.8: 11: Bye Bye [preauth]
•	Tail
#Tail is another command line tool that can display the latest changes from a file in real time. This is useful for monitoring ongoing processes, such as restarting a service or testing a code change. You can also use tail to print the last few lines of a file, or pair it with grep to filter the output from a log file.
#$ tail -f /var/log/auth.log | grep 'Invalid user'
#Apr 30 19:49:48 ip-172-31-11-241 sshd[6512]: Invalid user ubnt from 219.140.64.136
#pr 30 19:49:49 ip-172-31-11-241 sshd[6514]: Invalid user admin from 219.140.64.136
    -tail -n 15 #shows the last 15 lines
•	AWK
#awk works on programs that contain rules comprised of patterns and actions. The action is executed on the text that matches the pattern. Patterns are enclosed in curly braces ({}). Together, a pattern and an action form a rule. The entire awk program is enclosed in single quotes (').
#awk considers a field to be a string of characters surrounded by whitespace, the start of a line, or the end of a line. Fields are identified by a dollar sign ($) and a number. So, $1 represents the first field, which we’ll use with the print action to print the first field.
who | awk '{print $1,$4}'
•	$0: Represents the entire line of text.
•	$1: Represents the first field.
•	$2: Represents the second field.
•	$7: Represents the seventh field.
•	$45: Represents the 45th field.
•	$NF: Stands for “number of fields,” and represents the last field.
#Examples:
1) Amit     Physics   80
2) Rahul    Maths     90
3) Shyam    Biology   87
4) Kedar    English   85
5) Hari     History   89

awk '{print $3 "\t" $4}' marks.txt
Output
Physics   80
Maths     90
Biology   87