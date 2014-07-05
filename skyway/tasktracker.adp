<HTML>
<HEAD>
	<TITLE>Infinite Information Incorporated | Skyway - Task Tracker</TITLE>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	var btLocation;
	//-->
	</SCRIPT>
	<SCRIPT LANGUAGE="JavaScript" SRC="../javascript/shimages.js"></SCRIPT>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	if (document.images) {
		var sub1 = new Image();
		var sub2 = new Image();
		var sub3 = new Image();
		var sub4 = new Image();
		var sub5 = new Image();
		var sub6 = new Image();
		sub1.src = "shared/2btdocuments.gif";
		sub2.src = "shared/2btschedule.gif";
		sub3.src = "shared/2btreview.gif";
		sub4.src = "shared/2bttracker.gif";
		sub5.src = "shared/2bttransfer.gif";
		sub6.src = "shared/2btcontacts.gif";
	}
	//-->
	</SCRIPT>
	<SCRIPT LANGUAGE="JavaScript" SRC="../javascript/mouseover.js">
	<!--
	function highlight(img, location, newimg, desc) {
		if (desc) {
			window.status = desc;
			return true;
		}
	}
			
	function unhighlight(img, location, newimg) {window.status = ""; return true;}
	//-->
	</SCRIPT>
</HEAD>

<BODY BGCOLOR="#CCCCCC" BACKGROUND="../shared/bg.gif" TEXT="#000000" LINK="#000066" VLINK="#666699" ALINK="#3333CC">
<TABLE CELLPADDING=0 CELLSPACING=0 BORDER=0 WIDTH=605>
<TR>
	<TD ROWSPAN=6 VALIGN="TOP"><IMG SRC="title.gif" WIDTH=133 HEIGHT=99 BORDER=0 ALT="Inside Infinite"></TD>
	<TD ROWSPAN=6 VALIGN="TOP"><IMG SRC="../shared/top.gif" WIDTH=82 HEIGHT=18 BORDER=0><BR><IMG SRC="porthole.gif" WIDTH=82 HEIGHT=81 BORDER=0><BR><IMG SRC="../shared/bottom.gif" WIDTH=82 HEIGHT=18 BORDER=0></TD>
	<TD><IMG SRC="../shared/pixel.gif" WIDTH=191 HEIGHT=5 BORDER=0></TD>
	<TD><IMG SRC="../shared/pixel.gif" WIDTH=147 HEIGHT=5 BORDER=0></TD>
	<TD ROWSPAN=3 VALIGN="TOP"><IMG SRC="../shared/pixel.gif" WIDTH=36 HEIGHT=3 BORDER=0><BR><A HREF="../index.html"><IMG SRC="../shared/logo.gif" WIDTH=36 HEIGHT=36 BORDER=0 ALT="Home"></A></TD>
	<TD><IMG SRC="../shared/pixel.gif" WIDTH=16 HEIGHT=1 BORDER=0></TD>
</TR>
<TR>
	<TD><A HREF="../solutions/index.html" ONMOUSEOVER="highlight('a','../shared/'); highlight('section','../shared/','lsolutions', 'Infinite Solutions');" ONMOUSEOUT="unhighlight('a','../shared/'); unhighlight('section','../shared/','pixel');"><IMG SRC="../shared/bta.gif" NAME="a" WIDTH=26 HEIGHT=26 BORDER=0 ALT="Infinite Solutions"></A><A HREF="../portfolio/index.html" ONMOUSEOVER="highlight('b','../shared/'); highlight('section','../shared/','lportfolio', 'Infinite Portfolio');" ONMOUSEOUT="unhighlight('b','../shared/'); unhighlight('section','../shared/','pixel');"><IMG SRC="../shared/btb.gif" NAME="b" WIDTH=27 HEIGHT=26 BORDER=0 ALT="Infinite Portfolio"></A><A HREF="../inside/index.html" ONMOUSEOVER="highlight('c','../shared/'); highlight('section','../shared/','linside', 'Inside Infinite');" ONMOUSEOUT="unhighlight('c','../shared/'); unhighlight('section','../shared/','pixel');"><IMG SRC="../shared/btc.gif" NAME="c" WIDTH=26 HEIGHT=26 BORDER=0 ALT="Inside Infinite"></A><A HREF="../contactus/index.html" ONMOUSEOVER="highlight('d','../shared/'); highlight('section','../shared/','lcontactus', 'Contact Us');" ONMOUSEOUT="unhighlight('d','../shared/'); unhighlight('section','../shared/','pixel');"><IMG SRC="../shared/btd.gif" NAME="d" WIDTH=26 HEIGHT=26 BORDER=0 ALT="Contact Us"></A><A HREF="../news/index.html" ONMOUSEOVER="highlight('e','../shared/'); highlight('section','../shared/','lnews', 'News');" ONMOUSEOUT="unhighlight('e','../shared/'); unhighlight('section','../shared/','pixel');"><IMG SRC="../shared/bte.gif" NAME="e" WIDTH=26 HEIGHT=26 BORDER=0 ALT="News"></A><A HREF="../opportunities/index.html" ONMOUSEOVER="highlight('f','../shared/'); highlight('section','../shared/','lopportunities', 'Job Opportunities');" ONMOUSEOUT="unhighlight('f','../shared/'); unhighlight('section','../shared/','pixel');"><IMG SRC="../shared/btf.gif" NAME="f" WIDTH=26 HEIGHT=26 BORDER=0 ALT="Job Opportunities"></A><IMG SRC="../shared/2btg.gif" NAME="g" WIDTH=26 HEIGHT=26 BORDER=0 ALT="Skyway"></TD>
	<TD VALIGN="TOP"><IMG SRC="../shared/pixel.gif" WIDTH=147 HEIGHT=12 BORDER=0><BR><IMG SRC="../shared/pixel.gif" NAME="section" WIDTH=127 HEIGHT=7 BORDER=0></TD>
</TR>
<TR>
	<TD><IMG SRC="blank1.gif" WIDTH=23 HEIGHT=12 BORDER=0></TD>
</TR>

<%
	set formset	[ns_conn form]
	#if ![fetchformdata formset] {
	#	ns_puts "<h2>No form data passed.</h2>"
	#	return
	#}

	set username	[ns_set get $formset client]

	ns_adp_include displaynavbar.adp $username
%>

<TR>
	<TD><IMG SRC="blank5.gif" WIDTH=28 HEIGHT=51 BORDER=0></TD>
</TR>
<TR>
	<TD COLSPAN=6>
		<TABLE CELLPADDING=0 CELLSPACING=0 WIDTH="100%" BORDER=0>
		<TR>
			<TD ROWSPAN=2 VALIGN="TOP" WIDTH=325>
			<FONT FACE="verdana, arial, helvetica" COLOR="#000000" SIZE=-1>
				<BR><BR>
				
				<%
					set dimensions [ns_gifsize "[ns_adp_dir]/clients/$username/logo.gif"]
					set width	[lindex $dimensions 0]
					set height	[lindex $dimensions 1]

					ns_puts "<center><img src=\"clients/${username}/logo.gif\" width=$width height=$height border=0 alt=\"$username\"></center>"
					ns_puts "<form method=\"post\" action=\"http:/NS/Db/SearchQBF/infinite/${username}_tasks\">"
				%>

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
						set db		[ns_db gethandle infinite]
						set row	[ns_db select $db [ns_column value $db ${username}_tasks whose htmltag_data]]

						while {[ns_db getrow $db $row]} {
							append whose {<OPTION value='} [ns_set get $row name] {'>&nbsp;&nbsp;} [ns_set get $row name] \n
						}

						ns_puts $whose
					%>
					
					</SELECT>

					<BR>Tasks &nbsp;
					<INPUT TYPE="hidden" NAME="ColOperator.status" VALUE="=">
					<SELECT NAME="ColValue.status" size=1>
						<OPTION value="">
						<OPTION value="Open" selected>Open
						<OPTION value="Fixed">Fixed
						<OPTION value="Closed">Closed
						<OPTION value="Suspended">Suspended
						<OPTION value="Duplicate">Duplicate
					</SELECT>
					<P>order by
					<SELECT NAME="OrderBy.0" size=1>
					<OPTION value="">any column

					<%
						# Show all the columns for the tasks table.
						set columns {}

						foreach column [set printablecolumns [ns_listprintablecolumns $db ${username}_tasks]] {
							if [string match due_date $column] {
								set selected { selected}
							} else {
								set selected {}
							}
							append columns {<OPTION value='} $column {'} $selected {>&nbsp;&nbsp;} [ns_column value $db ${username}_tasks $column description] \n
						}

						foreach column $printablecolumns {
							append columns {<OPTION value='} $column { (reverse order)'>&nbsp;&nbsp;} [ns_column value $db ${username}_tasks $column description] { (reverse order)} \n
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
				<P><H2>Admin</H2>
				<P><A HREF="/NS/Db/GetEntryForm/infinite/titec_folks">Add a member to the team</A>
				<BR><A HREF="/NS/Db/SearchQBF/infinite/titec_folks">List the team members</A>
				<P><A HREF="/NS/Db/GetEntryForm/infinite/platforms">Add a platform</A>
				<BR><A HREF="/NS/Db/SearchQBF/infinite/platforms">List the platforms</A>
				<P><A HREF="/NS/Db/GetEntryForm/infinite/browsers">Add a browser</A>
				<BR><A HREF="/NS/Db/SearchQBF/infinite/browsers">List the browsers</A>
				<P><HR>
				<P>
			</FONT></TD>
			<TD VALIGN="TOP"><IMG SRC="../shared/pixel.gif" WIDTH=280 HEIGHT=14 BORDER=0><BR><IMG SRC="image.gif" WIDTH=228 HEIGHT=232 BORDER=0></TD>
		</TR>
		</TABLE></TD>
</TR>
</TABLE>
</BODY>
</HTML>