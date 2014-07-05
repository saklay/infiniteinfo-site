<%
	set formSet [ns_conn form]
	set id [ns_set get $formSet id]
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
	
	set sql "update directory
			 set last_name = $last_name,
			 	 first_name = $first_name,
				 email = $email,
				 title = $title,
				 area_code = $area_code,
				 phone_number = $phone_number,
				 extension = $extension,
				 home_phone = $home_phone,
				 mobile_phone = $mobile_phone,
				 location = $location,
				 projects = $projects
			 where id = $id"
	set db [ns_db gethandle infinite]
	set rowSet [ns_db dml $db $sql]
	
	ns_returnredirect index.adp
%>