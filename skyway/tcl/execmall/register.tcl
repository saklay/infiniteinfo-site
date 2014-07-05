##############################################################################
#	SeminarRegister
##############################################################################
#
#	Websters Inc, Copyright 1998
#
#	Synopsis:	Provide the registration page.
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
proc SeminarRegister {conn seminar db} {


    #
    # Get the HTML for the buttons.
    #
    set buttons [SeminarButtons $seminar "registernow"]
    set title [ns_set get $seminar title]
    set baseprice   [format %.0f [ns_set get $seminar baseprice]]
    set volumeprice [format %.0f [expr $baseprice * 0.9]]

    #
    # Determine the venue options.
    #
    set venues [SeminarVenues $seminar $db]

    # Snag the venues for the hidden field.
    set lvenues {}
    set singlevenue {}
    set multiplevenues {}
    for {set i 1} {$i <= 5} {incr i} {
	if { ![string match "" [set startdate [ns_set get $seminar startdate${i}]]] } {
	    set startmonth [ns_parsesqltimestamp month $startdate]
	    set startday   [ns_parsesqltimestamp day $startdate]
	    lappend lvenues "[ns_set get $seminar venue${i}] ($startmonth $startday)"
	}
    }

    if { [llength $lvenues] > 1 } {

	set multiplevenues "<TR>
	<TD>
	<FONT SIZE=-1>Venue:</FONT></TD>
	<TD COLSPAN=4>
	<select name=\"venue\">
	<option value=\"\"> &lt;pick venue&gt;\n"

	foreach lvenue $lvenues {	
	    append multiplevenues "<option value=\"${lvenue}\">${lvenue}\n"
	}

	append multiplevenues "</select></TD>\n</TR>\n"

    } else {
	set singlevenue "<INPUT TYPE=\"hidden\" NAME=\"venue\" VALUE=\"[lindex $lvenues 0]\">"
    }


    #
    # Early bird date for the discount statement.
    #
    set earlybird      [ns_set get $seminar earlybird]
    set earlybirdmonth [ns_parsesqltimestamp month $earlybird]
    set earlybirdday   [ns_parsesqltimestamp day $earlybird]
    set earlybirdyear  [ns_parsesqltimestamp year $earlybird]
    set earlybirdyearshort [string range $earlybirdyear 2 3]

    # Get the early bird date for the hidden field.
    set months [list January February March April May June \
	    July August September October November December]

    set earlybirdnmonth [expr [lsearch $months $earlybirdmonth] + 1]

    #
    # Show the page.
    #
    set page "<HTML>
<HEAD>
<TITLE>Executive Mall - Cyber Power : Register Now!</TITLE>

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

<P><CENTER>
	<TABLE CELLSPACING=0 CELLPADDING=3 BORDER=0 WIDTH=250>
	<TR>
	<TD BGCOLOR=\"#000000\" ALIGN=center>
	<FONT FACE=\"verdana, arial, helvetica\" SIZE=-1 COLOR=\"#FFFF99\"><STRONG>
	Register Now!</STRONG></FONT></TD></TR>
	</TABLE>

<P>

<FORM ACTION=\"/ExecMall/OrderStep1\" METHOD=\"POST\">

<INPUT TYPE=\"hidden\" NAME=\"name\" VALUE=\"$title\">
<INPUT TYPE=\"hidden\" NAME=\"investment\" VALUE=\"1:$baseprice 3:$volumeprice\">
$singlevenue
<INPUT TYPE=\"hidden\" NAME=\"earlybird\" VALUE=\"${earlybirdnmonth}/$earlybirdday/$earlybirdyearshort\">
<INPUT TYPE=\"hidden\" NAME=\"earlybirddiscount\" VALUE=\"0.10\">


<TABLE CELLSPACING=0 CELLPADDING=5 BORDER=0 WIDTH=100%>
<TR>
<TD>
        <STRONG><FONT FACE=\"arial, helvetica\">Investment:</FONT></STRONG>
	<TABLE CELLSPACING=0 CELLPADDING=6 BORDER=0 BGCOLOR=\"orange\">
	<TR>
	<TD BGCOLOR=\"#00416B\">
	<FONT FACE=\"arial, helvetica\" SIZE=-1 COLOR=\"#FFFFFF\"><STRONG>1-2 Delegates</STRONG></FONT></TD>
	<TD>
	<FONT FACE=\"arial, helvetica\" SIZE=-1><STRONG>[asmoney $baseprice]</STRONG><FONT SIZE=-2> + 10% VAT per delegate</FONT></FONT></TD>
	</TR>
	<TR>
	<TD BGCOLOR=\"#00416B\">
	<FONT FACE=\"arial, helvetica\" SIZE=-1 COLOR=\"#FFFFFF\"><STRONG>3+ Delegates</STRONG></FONT></TD>
	<TD>
	<FONT FACE=\"arial, helvetica\" SIZE=-1><STRONG>[asmoney $volumeprice]</STRONG><FONT SIZE=-2> + 10% VAT per delegate</FONT></FONT></TD>
	</TR>
	</TABLE> 

	<BR>
	<FONT FACE=\"arial, helvetica\" SIZE=-1>
	<EM>(NOTE: Fields marked by * are required.)</EM><BR>
	</FONT>

	<FONT FACE=\"arial, helvetica\">
	<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>
	<TR>
	<TD COLSPAN=4><BR>
	<FONT FACE=\"arial, helvetica\">
	<STRONG>Company Information:</STRONG></TD>
	</TR>
	<TR>
	<TD>
	<FONT SIZE=-1>Company *:</FONT></TD>
	<TD COLSPAN=4>
	<INPUT TYPE=text NAME=\"company\" SIZE=32 MAXLENGTH=80></TD>
	</TR>
	<TR>
	<TD>
	<FONT SIZE=-1>Address *:</FONT></TD>
	<TD COLSPAN=4>
	<INPUT TYPE=text NAME=\"address1\" SIZE=32 MAXLENGTH=80></TD>
	</TR>
	<TR>
	<TD></TD>
	<TD COLSPAN=4>
	<INPUT TYPE=text NAME=\"address2\" SIZE=32 MAXLENGTH=80></TD>
	</TR>
	<TR>
	<TD>
	<FONT SIZE=-1>City *:</FONT></TD>
	<TD>
	<INPUT TYPE=text NAME=\"city\" SIZE=20 MAXLENGTH=80></TD>
	<TD>
	<FONT SIZE=-1>Province/State:</FONT></TD>
	<TD>
	<INPUT TYPE=text NAME=\"state\"  SIZE=20 MAXLENGTH=80></TD>
	</TR>
	<TR>
	<TD>
	<FONT SIZE=-1>Country *:</FONT></TD>
	<TD>
	<INPUT TYPE=text NAME=\"country\" VALUE=\"Philippines\" SIZE=20 MAXLENGTH=80></TD>
	<TD>
	<FONT SIZE=-1>Postal/Zip:</FONT></TD>
	<TD>
	<INPUT TYPE=text NAME=\"zip\"  SIZE=20 MAXLENGTH=80></TD>
	</TR>
	<TR>
	<TD COLSPAN=4><BR>
	<FONT FACE=\"arial, helvetica\">
	<STRONG>Contact Person:</STRONG></TD>
	</TR>
	<TR>
	<TD>
	<FONT SIZE=-1>First Name *:</FONT></TD>
	<TD>
	<INPUT TYPE=text NAME=\"contact_first\" SIZE=20 MAXLENGTH=80></TD>
	<TD>
	<FONT SIZE=-1>Last Name *:</FONT></TD>
	<TD>
	<INPUT TYPE=text NAME=\"contact_last\"  SIZE=20 MAXLENGTH=80></TD>
	</TR>
	<TR>
	<TD>
	<FONT SIZE=-1>Title *:</FONT></TD>
	<TD COLSPAN=4>
	<INPUT TYPE=text NAME=\"title\" SIZE=32 MAXLENGTH=80></TD>
	</TR>
	<TR>
	<TD>
	<FONT SIZE=-1>Telephone *:</FONT></TD>
	<TD COLSPAN=4>
	<INPUT TYPE=text NAME=\"phone\" SIZE=20 MAXLENGTH=80></TD>
	</TR>
	<TR>
	<TD>
	<FONT SIZE=-1>Fax:</FONT></TD>
	<TD COLSPAN=4>
	<INPUT TYPE=text NAME=\"fax\" SIZE=20 MAXLENGTH=80></TD>
	</TR>
	<TR>
	<TD>
	<FONT SIZE=-1>E-Mail:</FONT></TD>
	<TD COLSPAN=4>
	<INPUT TYPE=text NAME=\"email\" SIZE=32 MAXLENGTH=80></TD>
	</TR>
	<TR>
	<TD COLSPAN=4><BR>
	<FONT FACE=\"arial, helvetica\">
	<STRONG>Seminar Information:</STRONG></TD>
	</TR>
        $multiplevenues
	<TR>
	<TD COLSPAN=4>
	<FONT SIZE=-1>Number of Attendees (including yourself, if applicable) *:</FONT>
	<INPUT TYPE=text NAME=\"num_attendees\" SIZE=3 MAXLENGTH=3></TD>
	</TR>
	<TR>
	<TD COLSPAN=4><BR>
	<FONT FACE=\"arial, helvetica\">
	<STRONG>Method of Payment:</STRONG><BR>
	<FONT SIZE=-1>Please charge my/our workshop fee to my/our credit card.<BR><BR>
	(NOTE: This is <STRONG>NOT</STRONG> a secure transaction!
	If you prefer, you may register without providing credit card
	information and we will contact you.)<BR><BR></FONT></TD>
	</TR>
	<TR>
	<TD>
	<FONT SIZE=-1>Card Holder:</FONT></TD>
	<TD COLSPAN=4>
	<INPUT TYPE=text NAME=\"card_holder\" SIZE=32 MAXLENGTH=80></TD>
	</TR>
	<TR>
	<TD>
	<FONT SIZE=-1>Credit Card:</FONT></TD>
	<TD COLSPAN=4>
	<select name=\"card_type\">
	<option value=\"\">
	<option value=\"AMEX\"> AMEX
	<option value=\"Unicard\"> Unicard
	<option value=\"Mastercard\"> Mastercard
	<option value=\"VISA\"> VISA
	<option value=\"BPI\"> BPI
	<option value=\"Bankard\"> Bankard
	<option value=\"Diners\"> Diners
	<option value=\"RCBC\"> RCBC
	<option value=\"Far East\"> Far East
	</select></TD>
	</TR>
	<TR>
	<TD>
	<FONT SIZE=-1>Card No:</FONT></TD>
	<TD>
	<INPUT TYPE=text NAME=\"card_no\" SIZE=20 MAXLENGTH=80></TD>
	<TD>
	<FONT SIZE=-1>Expiry Date:</FONT></TD>
	<TD>
	<select name=\"expiry_month\">
	<option value=\"1\"> Jan 
	<option value=\"2\"> Feb 
	<option value=\"3\"> Mar 
	<option value=\"4\"> Apr 
	<option value=\"5\"> May 
	<option value=\"6\"> Jun 
	<option value=\"7\"> Jul 
	<option value=\"8\"> Aug 
	<option value=\"9\"> Sep 
	<option value=\"10\"> Oct 
	<option value=\"11\"> Nov 
	<option value=\"12\"> Dec
	</select>
	<select name=\"expiry_year\">
	<option value=\"1998\" selected> 1998 
	<option value=\"1999\"> 1999 
	<option value=\"2000\"> 2000 
	<option value=\"2001\"> 2001 
	<option value=\"2002\"> 2002 
	<option value=\"2003\"> 2003 
	<option value=\"2004\"> 2004 
	<option value=\"2005\"> 2005
	</select><BR></TD>
	</TR>
	<TR>
	<TD COLSPAN=4><BR>
	<FONT FACE=\"arial,helvetica\" SIZE=-1>
	<STRONG>Contact:</STRONG><BR>
	Learning Concepts International, Inc.<BR>
	301 Tito Jovy Center<BR>
	Buencamino St.<BR>
	Alabang 1770, Muntinlupa City<BR>
	Philippines
	<P>
	<STRONG>Telephone Numbers:</STRONG><BR>
	807-5790<BR>
	698-3835-37<BR>
	698-4018 698-4020
	<P>
	<STRONG>Fax:</STRONG><BR>
	802-3426<BR>
	698-3837
	<P>
	<STRONG>Email</STRONG><BR>
	<A HREF=\"mailto:robert@easy.net.ph\">robert@easy.net.ph</A></FONT></TD>
	</TR>
	</TABLE>

	<P>
	<CENTER>
	<INPUT TYPE=image SRC=\"/execmall/shared/btcontinue.gif\" BORDER=0 VALUE=\"Continue\">
	</CENTER>

	<FONT FACE=\"verdana, arial, helvetica\" SIZE=-1>
	<A HREF=\"#top\">back to top</A></FONT>
</TD>

<TD WIDTH=200 VALIGN=\"TOP\">
	<TABLE CELLSPACING=0 CELLPADDING=2 BORDER=0 WIDTH=200 ALIGN=right>
	<TR>
	<TD BGCOLOR=\"#000000\">
		<TABLE CELLSPACING=0 CELLPADDING=2 BORDER=0 WIDTH=196 BGCOLOR=\"#FEFEC8\">
                <TR>
                <TD>
                $venues<HR>
                </TD>
                </TR>
		<TR>
		<TD><FONT FACE=\"arial, helvetica\" SIZE=-1>
		<FONT COLOR=\"#800000\"><STRONG>EARLY BIRD DISCOUNT:</STRONG>  The earlier you book, the more you save... Deduct 10% if paying before ${earlybirdmonth} ${earlybirdday}, ${earlybirdyear}!</FONT>	
		<P>
		<STRONG>CANCELLATION:</STRONG>  No cancellation within 7 days before the seminar date.  However, substitutes are welcome.
                </TD></TR>
		</TABLE></TD>
	</TR>
	</TABLE>

</TD>
</TR>
</TABLE>

</CENTER>

</FORM>
</BODY>
</HTML>
"

    ns_respond $conn -status 200 -type text/html -string $page

}
