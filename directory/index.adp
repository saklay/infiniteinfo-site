<HTML>
<HEAD>
	<TITLE>Infiniteinfo Directory</TITLE>
</HEAD>

<BODY BGCOLOR="#FFFFFF">
<FORM ACTION="add.html">
<TABLE CELLSPACING=0 CELLPADDING=5 BORDER=1>
<TR>
	<TD ALIGN="CENTER" NOWRAP><font face="verdana,helvetica,times new roman,arial" size=-1 color="#000000"><b>Name</b></FONT></TD>
	<TD ALIGN="CENTER" NOWRAP><font face="verdana,helvetica,times new roman,arial" size=-1 color="#000000"><b>Email</b></FONT></TD>
	<TD ALIGN="CENTER" NOWRAP><font face="verdana,helvetica,times new roman,arial" size=-1 color="#000000"><b>Position</b></FONT></TD>
	<TD ALIGN="CENTER" NOWRAP><font face="verdana,helvetica,times new roman,arial" size=-1 color="#000000"><b>Office Number</b></FONT></TD>
	<TD ALIGN="CENTER" NOWRAP><font face="verdana,helvetica,times new roman,arial" size=-1 color="#000000"><b>Extension</b></FONT></TD>
	<TD ALIGN="CENTER" NOWRAP><font face="verdana,helvetica,times new roman,arial" size=-1 color="#000000"><b>Projects</b></FONT></TD>
	<TD ALIGN="CENTER" NOWRAP><font face="verdana,helvetica,times new roman,arial" size=-1 color="#000000"><b>Home Number</b></FONT></TD>
	<TD ALIGN="CENTER" NOWRAP><font face="verdana,helvetica,times new roman,arial" size=-1 color="#000000"><b>Mobile Number</b></FONT></TD>
</TR>

<%
	set sql "select * from directory order by location, last_name"
	set db [ns_db gethandle infinite]
   	set rowSet [ns_db select $db $sql]
	
	set temp_location ""
	while {[ns_db getrow $db $rowSet]} {
		if {![string match $temp_location [set location [ns_set get $rowSet location]]]} {
			ns_puts "<tr><td colspan=8 bgcolor=\"#ff0000\"><IMG SRC=\"../shared/pixel.gif\" WIDTH=1 HEIGHT=3 BORDER=0></td></tr>"
			ns_puts "<tr>"
			ns_puts "<td><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\"><a href=\"edit_entry.adp?id=[ns_set get $rowSet id]\">[ns_set get $rowSet last_name], [ns_set get $rowSet first_name]</a></font></td>"
			ns_puts "<td><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\"><a href=\"mailto:[ns_set get $rowSet email]\">[ns_set get $rowSet email]</a></font></td>"
			ns_puts "<td><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">[ns_set get $rowSet title]</font></td>"
			if {[string match "" [ns_set get $rowSet phone_number]]} {
				ns_puts "<td><IMG SRC=\"../shared/pixel.gif\" WIDTH=1 HEIGHT=1 BORDER=0></td>"
			} else {
				set telephone ""
				if {![string match "" [ns_set get $rowSet area_code]]} {
					append telephone "([ns_set get $rowSet area_code]) "
				}
				append telephone [ns_set get $rowSet phone_number]
				#if {![string match "" [ns_set get $rowSet extension]]} {
				#	append telephone " ext. [ns_set get $rowSet extension]"
				#}
				ns_puts "<td><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">$telephone</font></td>"
			}
			ns_puts "<td><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">[ns_set get $rowSet extension]</font></td>"
			ns_puts "<td><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">[ns_set get $rowSet projects]</font></td>"
			ns_puts "<td><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">[ns_set get $rowSet home_phone]</font></td>"
			ns_puts "<td><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">[ns_set get $rowSet mobile_phone]</font></td>"
			ns_puts "</tr>"
			set temp_location $location
		} else {
			ns_puts "<tr>"
			ns_puts "<td><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\"><a href=\"edit_entry.adp?id=[ns_set get $rowSet id]\">[ns_set get $rowSet last_name], [ns_set get $rowSet first_name]</a></font></td>"
			ns_puts "<td><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\"><a href=\"mailto:[ns_set get $rowSet email]\">[ns_set get $rowSet email]</a></font></td>"
			ns_puts "<td><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">[ns_set get $rowSet title]</font></td>"
			if {[string match "" [ns_set get $rowSet phone_number]]} {
				ns_puts "<td><IMG SRC=\"../shared/pixel.gif\" WIDTH=1 HEIGHT=1 BORDER=0></td>"
			} else {
				set telephone ""
				if {![string match "" [ns_set get $rowSet area_code]]} {
					append telephone "([ns_set get $rowSet area_code]) "
				}
				append telephone [ns_set get $rowSet phone_number]
				#if {![string match "" [ns_set get $rowSet extension]]} {
				#	append telephone " ext. [ns_set get $rowSet extension]"
				#}
				ns_puts "<td><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">$telephone</font></td>"
			}
			ns_puts "<td><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">[ns_set get $rowSet extension]</font></td>"
			ns_puts "<td><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">[ns_set get $rowSet projects]</font></td>"
			ns_puts "<td><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">[ns_set get $rowSet home_phone]</font></td>"
			ns_puts "<td><font face=\"verdana,helvetica,times new roman,arial\" size=-1 color=\"#000000\">[ns_set get $rowSet mobile_phone]</font></td>"
			ns_puts "</tr>"
		}
	}
%>

</TABLE>
<BR>
<CENTER>
<INPUT TYPE="Submit" NAME="add" VALUE="Add">
</CENTER>
</FORM>
</BODY>
</HTML>