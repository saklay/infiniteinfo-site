##############################################################################
#	SeminarDefault
##############################################################################
#
#	Websters Inc, Copyright 1998
#
#	Synopsis:	Provide default pages for seminar.
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
proc SeminarDefault {conn seminar section db} {

    #
    # Get the HTML for the buttons.
    #
    set buttons [SeminarButtons $seminar $section]
    set title [ns_set get $seminar title]
    switch $section {
	outline   {set subtitle "Course Outline"}
	whyattend {set subtitle "Why Attend"}
	whoattend {set subtitle "Who Attend"}
	default   {set subtitle "[string toupper [string range $section 0 0]][string range $section 1 end]"}
    }

    #
    # Figure out the body of the text.
    #
    if { [string match "speaker" $section] } {
	set body {}
	set alignment LEFT
	for {set i 1} {$i <= 5} {incr i} {
	    if { ![string match "" [set speaker [ns_set get $seminar speaker${i}]]] } {
		set fullspeaker [ns_db 0or1row $db \
		    "select * from speakers where name = [ns_dbquotevalue $speaker]"]

		#
		# Do not return anything if there is no matching seminar.
		#
		if { ![string match "" $fullspeaker] } {
		    append body "\n<CENTER><FONT FACE=\"verdana, arial, helvetica\" COLOR=\"#006699\"><H2>" \
			    [ns_set get $fullspeaker name] "</H2></FONT></CENTER><BR>"
		    if { ![string match "" [set picture [ns_set get $fullspeaker picture]]] } {
			set alignment [expr [string match $alignment "RIGHT"]?"LEFT":"RIGHT"]
			append body "<IMG SRC=\"$picture\" BORDER=0 ALIGN=\"$alignment\""
		    }
		    append body "\n" [ns_set get $fullspeaker bio] "<HR>"
		}
	    }
	}
	regsub {<HR>$} $body "" body
    } else {
	set body [ns_set get $seminar $section]
    }

    #
    # Show the default page.
    #
    set page "<HTML>
<HEAD>
<TITLE>Executive Mall - Cyber Power : $subtitle</TITLE>

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
<A NAME=top>
<A HREF=\"/execmall/\"><IMG SRC=\"/execmall/shared/execmalllogo.gif\" WIDTH=253 HEIGHT=78 BORDER=0 ALIGN=right ALT=\"back to HomePage\"></A>

<FONT FACE=\"verdana, arial, helvetica\" SIZE=-1 COLOR=\"#0080FF\">
<H2>$title</H2>
		<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0 WIDTH=180>
		<TR>
		<TD>
		<A HREF=\"/execmall/\" onMouseOver=\"highlight('home','/execmall/shared/')\" onMouseOut=\"unhighlight('home','/execmall/shared/')\";>
		<IMG SRC=\"/execmall/shared/bthome.gif\" NAME=\"home\" WIDTH=152 HEIGHT=20 BORDER=0 ALT=\"Home\"></A></TD></TR>
                $buttons
		</TABLE>
		</FONT>

<P><BR><CENTER>
	<TABLE CELLSPACING=0 CELLPADDING=3 BORDER=0 WIDTH=250>
	<TR>
	<TD BGCOLOR=\"#000000\" ALIGN=center>
	<FONT FACE=\"verdana, arial, helvetica\" SIZE=-1 COLOR=\"#FFFF99\"><STRONG>
	$subtitle</STRONG></FONT></TD></TR>
	</TABLE>
</CENTER>
<P><FONT FACE=\"arial, helvetica\" SIZE=-1>

$body

<P>
<CENTER><FONT FACE=\"verdana, arial, helvetica\">
<A HREF=\"#top\">back to top</A></FONT>
</CENTER>

</BODY>
</HTML>
"

    ns_respond $conn -status 200 -type text/html -string $page

}
