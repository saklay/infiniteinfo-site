##############################################################################
#	SeminarOverview
##############################################################################
#
#	Websters Inc, Copyright 1998
#
#	Synopsis:	Provide overview of seminar.
#	Arguments:	connection, not used
#	Return:		nothing (returns page to client)
#	Side Effect:	none
#
#	Author:		Robert Locke
#	Date:		8/27/98
#
#	History:
#		ral	8/27/98		Initial Revision
#
##############################################################################
proc SeminarOverview {conn seminar db} {

    #
    # Get the HTML for the buttons.
    #
    set buttons [SeminarButtons $seminar overview]
    set title [ns_set get $seminar title]
    set venues [SeminarVenues $seminar $db]

    #
    # Show the overview page.
    #
    set page "<HTML>
<HEAD>
<TITLE>Executive Mall - $title</TITLE>

<SCRIPT LANGUANGE=\"JavaScript\">
<!--
// can the browser handle it?
function BrowserCan() {
    var x = navigator.userAgent.indexOf(\"Mozilla/\");
    if (x < 0) {
        return false;
    } 
    return (navigator.userAgent.substring(x+8,x+9)>=3);
}

// pre-load highlight images
if (BrowserCan()) {
    var img1 = new Image();
    var img2 = new Image();
    var img3 = new Image();
    var img4 = new Image();
    var img5 = new Image();
    var img6 = new Image();
    var img7 = new Image();
    var img8 = new Image();

    img1.src = \"/execmall/shared/2btcourseoutline.gif\";
    img2.src = \"/execmall/shared/2bthome.gif\";
    img3.src = \"/execmall/shared/2btoverview.gif\";
    img4.src = \"/execmall/shared/2btregisternow.gif\";
    img5.src = \"/execmall/shared/2btspeaker.gif\";
    img6.src = \"/execmall/shared/2bttestimonials.gif\";
    img7.src = \"/execmall/shared/2btwhoattend.gif\";
    img8.src = \"/execmall/shared/2btwhyattend.gif\";
}


//highlight link
function highlight(img, location) {
    if (BrowserCan()) {
		document.images\[img\].src = location + \"2bt\" + img + \".gif\";
    }
}
function unhighlight(img, location) {
    if (BrowserCan()) {
		document.images\[img\].src = location + \"bt\" + img + \".gif\";
    }
}

//-->
</SCRIPT>

</HEAD>
<BODY BGCOLOR=\"#ffcc99\">
<A NAME=\"top\">
<A HREF=\"/execmall/\"><IMG SRC=\"/execmall/shared/execmalllogo.gif\" WIDTH=253 HEIGHT=78 BORDER=0 ALIGN=right ALT=\"back to HomePage\"></A>

<FONT FACE=\"verdana, arial, helvetica\" COLOR=\"#003D98\">
<H1>$title</H1></FONT>

<P><BR><BR>
	<CENTER>
	<TABLE CELLSPACING=0 CELLPADDING=3 BORDER=0 WIDTH=250>
	<TR>
	<TD BGCOLOR=\"#000000\" ALIGN=center>
	<FONT FACE=\"verdana, arial, helvetica\" SIZE=-1 COLOR=\"#FFFF99\"><STRONG>
	Overview</STRONG></FONT></TD></TR>
	</TABLE></CENTER>

<CENTER>
<P>
<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH=90%>
<TR>
<TD>
<FONT FACE=\"arial, helvetica\" SIZE=-1>
		<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 ALIGN=left WIDTH=160>
		<TR>
		<TD>
		<A HREF=\"/execmall/\" onMouseOver=\"highlight('home','/execmall/shared/')\" onMouseOut=\"unhighlight('home','/execmall/shared/')\";>
		<IMG SRC=\"/execmall/shared/bthome.gif\" NAME=\"home\" VSPACE=2 WIDTH=152 HEIGHT=20 BORDER=0 ALT=\"Home\"></A></TD></TR>
                $buttons
		</TABLE>

	<TABLE CELLSPACING=0 CELLPADDING=2 ALIGN=right BORDER=0 WIDTH=200>
	<TR>
	<TD BGCOLOR=\"#000000\">
	<TABLE CELLSPACING=0 CELLPADDING=2 BORDER=0 BGCOLOR=\"#FEFEC8\">
        <TR>
        <TD>
        $venues
        </TD>
        </TR>
	</TABLE></TD></TR>
	</TABLE>

[ns_set get $seminar overview]

</TD></TR>
</TABLE>
<P>
<FONT FACE=\"verdana, arial, helvetica\" SIZE=-1>
<A HREF=\"#top\">back to top</A>
</CENTER>

</BODY>
</HTML>"

    ns_respond $conn -status 200 -type text/html -string $page

}
