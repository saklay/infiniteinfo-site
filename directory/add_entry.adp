<%
	set formSet [ns_conn form]
	set last_name [ns_dbquotevalue [ns_set get $formSet last_name]]
	set first_name [ns_dbquotevalue [ns_set get $formSet first_name]]
	set email [ns_dbquotevalue [ns_set get $formSet email]]
	set title [ns_dbquotevalue [ns_set get $formSet title]]
	set area_code [ns_dbquotevalue [ns_set get $formSet area_code]]
	set phone_number [ns_dbquotevalue [ns_set get $formSet phone_number]]
	set extension [ns_dbquotevalue [ns_set get $formSet extension]]
	set home_phone [ns_dbquotevalue [ns_set get $formSet home_phone]]
	set mobile_phone [ns_dbquotevalue [ns_set get $formSet mobile_phone]]
	set location [ns_dbquotevalue [ns_set get $formSet location]]
	set projects [ns_dbquotevalue [ns_set get $formSet projects]]
	
	set sql "select max(id) as maxid from directory"
	set db [ns_db gethandle infinite]
	set max_id [ns_db 1row $db $sql]
	set id [ns_set get $max_id maxid]
	incr id
	
	set sql2 "insert into directory
			 (id, last_name, first_name, email, title, area_code, phone_number, extension, home_phone, mobile_phone, location, projects)
			 values
			 ($id, $last_name, $first_name, $email, $title, $area_code, $phone_number, $extension, $home_phone, $mobile_phone, $location, $projects)"
			 
	set rowSet [ns_db dml $db $sql2]
	ns_returnredirect index.adp
%>