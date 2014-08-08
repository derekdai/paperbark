#
# Regular cron jobs for the paperbark package
#
0 4	* * *	root	[ -x /usr/bin/paperbark_maintenance ] && /usr/bin/paperbark_maintenance
