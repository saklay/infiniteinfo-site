#
#
# Skyway Project: Infinite Information Inc.
#
# Last Modified: August 12, 1999 03:44
#
#
#

ns_register_proc GET /skyway Skyway

proc Skyway { conn unused_argument } {

	# if cookie doesn't exist, it redirects the user
	# to the Skyway login screen

	# getCookie procedure under "cookie.tcl"
	set username	[getCookie kookie]
	set password	[getCookie monster]
	if {[string match "" $password] != 0 && [string match "" $username] != 0} {
		setCookie kookie $username 2
		setCookie monster $password 2
		ns_returnfile 200 text/html "[ns_info pageroot][ns_conn url]"
	} else {
		#ns_returnredirect "http://www.infiniteinfo.com/skyway/index.html"
		ns_returnredirect "http://www.infiniteinfo-l.com/skyway/index.html"
	}

}

ns_register_proc POST /skyway/login Login

proc Login { } {

	set formSet	[ns_conn form]
	set username	[ns_set get $formSet username]
	set password	[ns_set get $formSet password]

	if {[string match "" $password] == 0} {
		set sql		"select * from userdb where username = '$username' and password = '$password'"
		set db		[ns_db gethandle infinite]
		set rowSet	[ns_db 0or1row $db $sql]
	} else {
		ns_returnredirect "index.html"
	}

	if {![string match "" $rowSet]} {
		# setCookie procedure under "cookie.tcl"
		setCookie kookie $username 4
		setCookie monster $password 4
		ns_adp_parse -file "/usr/local/aolserver/servers/infinite/pages/skyway/valid.adp" $username
	} else {
		ns_adp_parse -file -global "http://www.infiniteinfo-l.com/skyway/valid.adp" $username
	}

}