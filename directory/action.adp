<HTML>
<HEAD>
	<TITLE>Infiniteinfo Directory</TITLE>
</HEAD>

<BODY>

<%
	set formSet [ns_conn form]
	set id [ns_set get $formSet id]

	if {[string match "Delete" [ns_set get $formSet delete]]} {
		ns_adp_include delete.adp $id
	}
	
	if {[string match "Update" [ns_set get $formSet update]]} {
		ns_adp_include update.adp $formSet
	}

%>

</BODY>
</HTML>
