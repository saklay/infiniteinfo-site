#
# skyway.tcl
#


proc savePassword {client} {
	if {[string match "" $client]} {
		set clientId	[lindex $client 0]
		set clientSet	[lindex $client 1]
	}
}


proc CheckClientId { }  {
	if {[set client [GetId]] == 0} {
		set clientId	[firstTime]
		set clientSet	[ns_state_view $clientId]
		ns_updateheader Set-Cookie "clientId=$clientId; path=/;"
	} else {
		set clientId	[lindex $client 0]
		set clientSet	[lindex $client 1]
	}
	ns_set update $clientSet password $password
}


proc GetId { } {
	if {[string compare "" [set clientId [CheckId]]] == 0 || \
		[string compare "" [set clientSet [ns_state_view $clientId]]] == 0} {
		return 0
	} else {
		return [list $clientId $clientSet]
	}
}


proc CheckId { } {
	set clientId ""
	regexp {^clientId=(.+)} [ns_set iget [ns_conn headers] Cookie] \
		null clientId

	return $clientId
}


proc firstTime {} {
	return [ns_state_save [ns_set new client]]
}