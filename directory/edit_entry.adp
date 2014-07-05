<HTML>
<HEAD>
	<TITLE>Infiniteinfo Directory</TITLE>
</HEAD>

<BODY>
<FORM METHOD="POST" ACTION="action.adp">
<TABLE CELLSPACING=0 CELLPADDING=5 BORDER=1>

<%
	set formSet [ns_conn form]
	set id [ns_set get $formSet id]
	set sql "select * from directory where id = $id"
	set db [ns_db gethandle infinite]
	set rowSet [ns_db 0or1row $db $sql]
	
	if {![string match "" $rowSet]} {
		ns_puts "<input type=\"hidden\" name=\"id\" value=$id>"
		ns_puts "<tr><td nowrap><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">Last Name</font></td><td><input type=\"text\" name=\"last_name\" value=\"[ns_set get $rowSet last_name]\"></td></tr>"
		ns_puts "<tr><td nowrap><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">First Name</font></td><td><input type=\"text\" name=\"first_name\" value=\"[ns_set get $rowSet first_name]\"></td></tr>"
		ns_puts "<tr><td nowrap><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">Email</font></td><td><input type=\"text\" name=\"email\" value=\"[ns_set get $rowSet email]\"></td></tr>"
		ns_puts "<tr><td nowrap><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">Position</font></td><td><input type=\"text\" name=\"title\" value=\"[ns_set get $rowSet title]\"></td></tr>"
		ns_puts "<tr><td nowrap><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">Area Code</font></td><td><input type=\"text\" name=\"area_code\" value=\"[ns_set get $rowSet area_code]\"></td></tr>"
		ns_puts "<tr><td nowrap><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">Phone Number</font></td><td><input type=\"text\" name=\"phone_number\" value=\"[ns_set get $rowSet phone_number]\"></td></tr>"
		ns_puts "<tr><td nowrap><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">Extension</font></td><td><input type=\"text\" name=\"extension\" value=\"[ns_set get $rowSet extension]\"></td></tr>"
		ns_puts "<tr><td nowrap><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">Projects</font></td><td><textarea name=\"projects\" cols=20 rows=10>[ns_set get $rowSet projects]</textarea></td></tr>"
		ns_puts "<tr><td nowrap><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">Home Number</font></td><td><input type=\"text\" name=\"home_phone\" value=\"[ns_set get $rowSet home_phone]\"></td></tr>"
		ns_puts "<tr><td nowrap><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">Mobile Number</font></td><td><input type=\"text\" name=\"mobile_phone\" value=\"[ns_set get $rowSet mobile_phone]\"></td></tr>"
		ns_puts "<tr><td nowrap><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">Location</font></td><td><input type=\"text\" name=\"location\" value=\"[ns_set get $rowSet location]\"></td></tr>"
	}
%>

</TABLE>
<BR>
&nbsp;&nbsp;<INPUT TYPE="Submit" NAME="update" VALUE="Update">&nbsp;&nbsp;<INPUT TYPE="Submit" NAME="delete" VALUE="Delete">
</FORM>

</BODY>
</HTML>
