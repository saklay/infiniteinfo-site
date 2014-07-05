<%
	set formSet [ns_conn form]
	set id [ns_set get $formSet id]
	
	set sql "delete from directory where id = $id"
	set db [ns_db gethandle infinite]
	set rowSet [ns_db dml $db $sql]
	
	ns_returnredirect index.adp
%>