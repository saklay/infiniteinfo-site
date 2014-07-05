<HTML>
<HEAD>
  <TITLE>TaskTracker</TITLE>
</HEAD>
<BODY BGCOLOR="#FFFFFF">
<P>
<H1>Titec</H1>

<P>
<H2>Task Tracker</H2>

<FORM METHOD="POST" ACTION="http:/NS/Db/SearchQBF/infinite/titec_tasks">

<INPUT TYPE="hidden" NAME="ColSelected.number" VALUE="on">
<INPUT TYPE="hidden" NAME="ColSelected.status" VALUE="on">
<INPUT TYPE="hidden" NAME="ColSelected.severity" VALUE="on">
<INPUT TYPE="hidden" NAME="ColSelected.due_date" VALUE="on">
<INPUT TYPE="hidden" NAME="ColSelected.whose" VALUE="on">
<INPUT TYPE="hidden" NAME="ColSelected.reporter" VALUE="on">
<INPUT TYPE="hidden" NAME="ColSelected.summary" VALUE="on">

<INPUT TYPE="SUBMIT" VALUE="Find">
<INPUT TYPE="hidden" NAME="ColOperator.whose" VALUE="=">
<SELECT NAME="ColValue.whose" size=1>
<OPTION value="" selected>anyone
<%
# Query the database and display all the products.
set whose {}
set db [ns_db gethandle infinite]
set row [ns_db select $db \
            [ns_column value $db titec_tasks whose htmltag_data]]
while { [ns_db getrow $db $row] } {
    append whose {<OPTION value='} [ns_set get $row name] {'>&nbsp;&nbsp;} [ns_set get $row name] \n
}
ns_puts $whose
%>
</SELECT>
's
<INPUT TYPE="hidden" NAME="ColOperator.status" VALUE="=">
<SELECT NAME="ColValue.status" size=1>
<OPTION value="">
<OPTION value="Open" selected>Open
<OPTION value="Fixed">Fixed
<OPTION value="Closed">Closed
<OPTION value="Suspended">Suspended
<OPTION value="Duplicate">Duplicate
</SELECT>
tasks<BR>
in
Titec<BR>
order by
<SELECT NAME="OrderBy.0" size=1>
<OPTION value="">any column
<%
# Show all the columns for the tasks table.
set columns {}
foreach column [set printablecolumns [ns_listprintablecolumns $db titec_tasks]] {
    if [string match due_date $column] {
        set selected { selected}
    } else {
        set selected {}
    }
    append columns {<OPTION value='} $column {'} $selected {>&nbsp;&nbsp;} [ns_column value $db titec_tasks $column description] \n
}
foreach column $printablecolumns {
    append columns {<OPTION value='} $column { (reverse order)'>&nbsp;&nbsp;} [ns_column value $db titec_tasks $column description] { (reverse order)} \n
}
ns_puts $columns
%>
</SELECT>

<P>
<CENTER>
<INPUT TYPE="BUTTON" VALUE="New Task" onClick="parent.location.href='/NS/Db/GetEntryForm/infinite/titec_tasks'">
<INPUT TYPE="BUTTON" VALUE="Search Tasks" onClick="parent.location.href='/NS/Db/GetSearchForm/infinite/titec_tasks'">
</CENTER>
</FORM>

  <HR>

<P>
<H2>Admin</H2>

<P>
<A HREF="/NS/Db/GetEntryForm/infinite/titec_folks">Add a member to the team</A>
<BR>
<A HREF="/NS/Db/SearchQBF/infinite/titec_folks">List the team members</A>

<P>
<A HREF="/NS/Db/GetEntryForm/infinite/platforms">Add a platform</A>
<BR>
<A HREF="/NS/Db/SearchQBF/infinite/platforms">List the platforms</A>

<P>
<A HREF="/NS/Db/GetEntryForm/infinite/browsers">Add a browser</A>
<BR>
<A HREF="/NS/Db/SearchQBF/infinite/browsers">List the browsers</A>
<P>
  <HR>
<P>
</BODY></HTML>
