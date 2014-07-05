##############################################################################
#
#	Websters Inc, Copyright 1997
#
#	Author:		Robert Locke
#	File:		order.tcl
#	Date:		11/27/97
#
#	Description:
#		For ordering books and subscribing to seminars online.
#
#	History:
#		ral	11/27/97	Initial Revision
#
##############################################################################

ns_register_proc POST /ExecMall/OrderStep1	OrderStep1
ns_register_proc POST /ExecMall/OrderStep2	OrderStep2

##############################################################################
#	OrderStep1
##############################################################################
#
#	Websters Inc, Copyright 1997
#
#	Synopsis:	Handles 1st step of order process.
#	Arguments:	connection id, not used
#	Return:		nothing (returns page to user)
#	Side Effect:	none
#	Strategy:
#		Verify appropriate fields have been filled in and validate
#		the data.
#		If not, return an error page.
#		Otherwise, return a page allowing the user to fill-in
#		the attendees.
#
#	Author:		rlocke
#	Date:		11/27/97
#
#	History:
#		ral	11/27/97	Initial Revision
#
##############################################################################
proc OrderStep1 {conn notused} {

    ns_share defaultFont

    #
    # Check for valid form data.
    #
    if ![getformdata $conn formSet] {
	return
    }

    #
    # Log onto the database.
    #
    set db [ns_db gethandle]

    #
    # Initialize the web page.
    #
    set page [InitPage $formSet]

    #
    # The required fields for this table.
    #
    set required {company address1 city country \
	    contact_last contact_first title phone \
	    venue num_attendees name investment}

    #
    # Check that the required fields have been filled out.
    #
    set missing {}
    foreach field $required {
	if {[string match "" [ns_set get $formSet $field]]} {
	    set description [ns_column value $db orders $field description]
	    append missing "<li>" $description "\n"
        }
    }

    if {![string match "" $missing]} {
	append page "${defaultFont}Please hit the back button of your browser
and fill in all the necessary fields.
<P>You are missing: <UL><UL>$missing</UL></UL>
</FONT>
</BODY>
</HTML>
"
	ns_respond $conn -status 400 -type text/html \
		-string $page
        return
    }

    #
    # Check that the attendees field is a real number.
    #
    if {![regexp {^[0-9]+$} [set num_attendees [ns_set get $formSet num_attendees]]] \
	    || $num_attendees <= 0} {
	append page "${defaultFont}'$num_attendees' is not a valid number of attendees.<P>
Please hit the back button of your browser and correctly specify
the number of people attending, <I>including</I> yourself if applicable.
</FONT>
</BODY>
</HTML>"

	ns_respond $conn -status 400 -type text/html \
		-string $page
	return
    }

    #
    # Return a page for step 2 of the process.  All the fields from step one
    # will be included as invisible form elements.
    #
    append page {<FORM ACTION="/ExecMall/OrderStep2" METHOD="POST">} "\n"
    for {set i 0} {$i < [ns_set size $formSet]} {incr i} {
	append page {<INPUT TYPE="hidden" NAME="} [ns_set key $formSet $i] \
		{" VALUE="} [ns_set value $formSet $i] {">} "\n"
    }

    #
    # Now add information for every attendee.
    #
    append page "${defaultFont}Please fill in the information for your $num_attendees attendees, including yourself if applicable:</FONT><BR><BR>\n"
    append page "<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>\n"

    for {set i 1} {$i <= $num_attendees} {incr i} {
	append page "<TR>
<TD WIDTH=20>
<STRONG>${defaultFont}$i.</FONT></STRONG></TD>
<TD WIDTH=85>
${defaultFont}First Name:</FONT></TD>
<TD>
<INPUT TYPE=text NAME=\"first_name_${i}\" SIZE=20 MAXLENGTH=80></TD>
<TD>
${defaultFont}Last Name:</FONT></TD>
<TD>
 <INPUT TYPE=text NAME=\"last_name_${i}\" SIZE=20 MAXLENGTH=80></TD>
</TR>
<TR>
<TD></TD>
<TD>
${defaultFont}Title:</FONT></TD>
<TD COLSPAN=2>
 <INPUT TYPE=text NAME=\"title_${i}\" SIZE=32 MAXLENGTH=80></TD>
</TR>
<TR>
<TD COLSPAN=5><HR></TD>
</TR>
"
    }

    #
    # Close out the page and add the current local date.
    #
    append page "</TABLE>\n<BR>\n<CENTER><INPUT TYPE=image SRC=\"/execmall/shared/btcontinue.gif\" BORDER=0 VALUE=\"Continue\"></CENTER>\n"

    append page "<SCRIPT LANGUAGE=\"JavaScript\">
    <!--
    dd = new Date();
    document.write('<input type=\"hidden\" name=\"localdate\" value=\"');
    document.write(dd.getMonth()+1);
    document.write('/');
    document.write(dd.getDate());
    document.write('/');
    document.write(dd.getYear());
    document.write('\">');
    //-->
    </SCRIPT>"

    append page "</FORM>\n</BODY>\n</HTML>"

    ns_respond $conn -status 200 -type text/html \
	    -string $page
}


##############################################################################
#	OrderStep2
##############################################################################
#
#	Websters Inc, Copyright 1997
#
#	Synopsis:	Handles 2nd step of registration process.
#	Arguments:	connection id, not used
#	Return:		nothing (returns confirmation page to user)
#	Side Effect:	none
#	Strategy:
#		Verify the attendee information.
#		Insert the order into the database.
#		Produce an order summary.
#
#	Author:		rlocke
#	Date:		11/27/97
#
#	History:
#		ral	11/27/97	Initial Revision
#
##############################################################################
proc OrderStep2 {conn notused} {

    ns_share defaultFont

    #
    # Check for valid form data.
    #
    if ![getformdata $conn formSet] {
	return
    }

    #
    # Initialize the result page.
    #
    set page [InitPage $formSet]

    #
    # Verify that the attendee information is complete.
    #
    set missing {}
    for {set i 1} {$i <= [set num_attendees [ns_set get $formSet num_attendees]]} \
	    {incr i} {
	foreach field {last_name first_name title} {
	    if {[string match "" [ns_set get $formSet ${field}_${i}]]} {
		lappend missing $i
		break
	    }
	}
    }

    if {[set num_missing [llength $missing]]} {
	if {$num_missing > 1} {
	    set plural s
	    set verb   have
	} else {
	    set plural {}
	    set verb   has
	}
	set missing [join $missing ", "]
	append page "${defaultFont}Attendee${plural} #${missing} $verb incomplete information.<BR><BR>
Please use the back button of your browser to complete the attendee list.</FONT>
</BODY>
</HTML>
"
        ns_respond $conn -status 400 -type text/html \
		-string $page
        return
    }

    #
    # Insert the data into the database.
    # We first work on the orders table.
    #
    set db [ns_db gethandle]
    set ordersSet [ns_set new orders]

    foreach column [ns_listprintablecolumns $db orders] {
	ns_set update $ordersSet ColValue.[ns_urlencode $column] \
		[ns_set get $formSet $column]
    }

    #
    # Determine the calculated fields:
    # id, expiry date, subtotal, tax, discount, total, order_date
    #
    ns_share VAT
    global tcl_precision
    set tcl_precision 17
    set discount 0.00

    #
    # Get the price based on the number of attendees.
    # A value of
    #     "1:9750 3:8950 6:7500"
    # means:
    #     1 - 2 attendees = P9,750
    #     3 - 5 attendees = P8,950
    #     6+    attendees = P7,500
    #
    set investment [lsort -decreasing [ns_set get $formSet investment]]

    for {set i 0} {$i < [llength $investment]} {incr i} {
	set value [split [lindex $investment $i] :]
	if {$num_attendees >= [lindex $value 0]} {
	    set unit_price [format %.2f [lindex $value 1]]
	    set subtotal [expr $num_attendees * [lindex $value 1]]
	    break
	}
    }

    #
    # Get any discounts based on early bird registrations.
    # Since the server is in the States, we use the date on the user's
    # computer.
    #
    if {![string match "" [set earlybird [ns_set get $formSet earlybird]]]} {
	set earlybird [split $earlybird /]
	set localdate [split [ns_set get $formSet localdate] /]
	set earlybirddiscount [ns_set get $formSet earlybirddiscount]

	if {([lindex $localdate 2] <  [lindex $earlybird 2])  ||
            ([lindex $localdate 2] == [lindex $earlybird 2] &&
	     [lindex $localdate 0] <  [lindex $earlybird 0])  ||
            ([lindex $localdate 2] == [lindex $earlybird 2] &&
             [lindex $localdate 0] == [lindex $earlybird 0] &&
             [lindex $localdate 1] <= [lindex $earlybird 1])} {
		 set discount [expr $subtotal * $earlybirddiscount]
        }
    }

    set tax [expr ($subtotal - $discount) * $VAT]
    set total [expr $subtotal - $discount + $tax]

    ns_set update $ordersSet ColValue.[ns_urlencode unit_price] $unit_price
    ns_set update $ordersSet ColValue.[ns_urlencode subtotal] $subtotal
    ns_set update $ordersSet ColValue.[ns_urlencode discount] $discount
    ns_set update $ordersSet ColValue.[ns_urlencode tax]      $tax
    ns_set update $ordersSet ColValue.[ns_urlencode total]    $total
    ns_set update $ordersSet ColValue.[ns_urlencode expiry] \
	    [ns_buildsqldate \
	    [ns_set get $formSet expiry_month] \
	    1 \
	    [ns_set get $formSet expiry_year]]

    #
    # Work on the order_lines table.
    #
    for {set i 1} {$i <= $num_attendees} {incr i} {
	set order_linesSet [ns_set new order_lines${i}]
	lappend order_linesSets $order_linesSet

	ns_set update $order_linesSet ColValue.[ns_urlencode item_id] $i
	foreach field {last_name first_name title} {
	    ns_set update $order_linesSet ColValue.[ns_urlencode $field] \
		    [ns_set get $formSet ${field}_${i}]
	}
    }    

    #
    # And now insert the data into the database.
    #
    # Begin the transaction:  if there are any subsequent errors then 
    # everything rolls back to this point.
    #
    ns_db dml $db {begin transaction}

    #
    # Get an id from the autogen table.
    #
    set orderId [ns_set get [ns_db 1row $db \
	    {select id from autogen where field = 'orders.id'}] id]

    ns_db dml $db \
	    {update autogen set id = id + 1 where field = 'orders.id'}

    ns_set update $ordersSet ColValue.[ns_urlencode id] $orderId

    #
    # Insert into the orders table.
    #
    if [catch {
	ns_insertrow $db orders $ordersSet
    } errMsg] {
	return [ns_dbreturnerror $conn $db "Could Not Process Registration"]
    }

    #
    # Insert into the order_lines table.
    #
    foreach order_linesSet $order_linesSets {
	ns_set update $order_linesSet ColValue.[ns_urlencode order_id] $orderId

	if [catch {
	    ns_insertrow $db order_lines $order_linesSet
	} errMsg] {
	    return [ns_dbreturnerror $conn $db "Could Not Process Registration"]
	}
    }

    #
    # Commit the transaction if we've gotten this far.
    #
    ns_db dml $db {end transaction}

    #
    # Now return an acknowledgement page.
    #
    append page "${defaultFont}<H2>Your registration was successful!</H2>" "\n"
    append page "Please retain the following for your records:<BR><BR></FONT>" "\n"

    append page [ShowOrderTable $ordersSet $order_linesSets]

    append page "</BODY>\n</HTML>"
    ns_respond $conn -status 200 -type text/html \
		-string $page

}


##############################################################################
#	ShowOrderTable
##############################################################################
#
#	Websters Inc, Copyright 1997
#
#	Synopsis:	Creates a formatted table containing order information.
#	Arguments:	order sets
#	Return:		Returns raw HTML
#	Side Effect:	none
#	Strategy:
#		Print out the order information.
#	Author:		rlocke
#	Date:		11/27/97
#
#	History:
#		ral	11/27/97	Initial Revision
#
##############################################################################
proc ShowOrderTable {ordersSet order_linesSets {admin 0}} {

    ns_share defaultFont

    #
    # Set the title for the page.
    #
    set name  [ns_set get $ordersSet ColValue.[ns_urlencode name]]
    set venue [ns_set get $ordersSet ColValue.[ns_urlencode venue]]

    if {$admin} {
	set date [ns_set get $ordersSet ColValue.[ns_urlencode order_date]]
	set time [lindex $date 1]

        set date "[ns_parsesqldate month $date]
                  [ns_parsesqldate day   $date],
                  [ns_parsesqldate year  $date]<BR>
                  [ns_parsesqltime time  $time]
                  [ns_parsesqltime ampm  $time]<BR>"

    } else {
	set date {}
    }

    set page "${defaultFont}<H3 ALIGN=RIGHT>
<B><U># [ns_set get $ordersSet ColValue.[ns_urlencode id]]</U></B><BR>
</H3>
<P ALIGN=RIGHT>
    <I>
        $date<BR>
	$name<BR>
        $venue
    </I>
</P>
</FONT>
<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=4 WIDTH=100%>
    <TR>
        <TH>${defaultFont}Company Information</FONT></TH>
        <TH>${defaultFont}Contact Information</FONT></TH>
    </TR>

    <TR>
        <TD VALIGN=TOP>
        ${defaultFont}
	[ns_set get $ordersSet ColValue.[ns_urlencode company]]<BR>
	[ns_set get $ordersSet ColValue.[ns_urlencode address1]]<BR>
	[ns_set get $ordersSet ColValue.[ns_urlencode address2]]<BR>
	[ns_set get $ordersSet ColValue.[ns_urlencode city]] [ns_set get $ordersSet ColValue.[ns_urlencode state]]<BR>
        [ns_set get $ordersSet ColValue.[ns_urlencode country]] [ns_set get $ordersSet ColValue.[ns_urlencode zip]]
        </FONT>
	</TD>

	<TD VALIGN=TOP>
        ${defaultFont}
	[ns_set get $ordersSet ColValue.[ns_urlencode contact_first]] [ns_set get $ordersSet ColValue.[ns_urlencode contact_last]]<BR>
	[ns_set get $ordersSet ColValue.[ns_urlencode title]]<BR>
	[ns_set get $ordersSet ColValue.[ns_urlencode phone]]<BR>
	[ns_set get $ordersSet ColValue.[ns_urlencode fax]]<BR>
	<A HREF=\"mailto:[ns_set get $ordersSet ColValue.[ns_urlencode email]]\">[ns_set get $ordersSet ColValue.[ns_urlencode email]]</A>
	</FONT>
	</TD>
    </TR>
</TABLE>
<BR>

<CENTER>
$defaultFont
<STRONG>Seminar Information</STRONG>
</FONT>
<BR>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0>
<TD WIDTH=300>
$defaultFont
$name<BR>
$venue<BR>
Number of attendees:<BR><BR>
Subtotal:<BR>
(Less) Discount:<BR>
VAT:<BR>
<HR>
<STRONG>Total:</STRONG><BR>
</FONT>
</TD>
<TD ALIGN=RIGHT>
$defaultFont
[ns_set get $ordersSet ColValue.[ns_urlencode package]]<BR><BR>
[ns_set get $ordersSet ColValue.[ns_urlencode num_attendees]] <FONT SIZE=-2>@</FONT> [asmoney [ns_set get $ordersSet ColValue.[ns_urlencode unit_price]]]<BR><BR>
[asmoney [ns_set get $ordersSet ColValue.[ns_urlencode subtotal]]]<BR>
[asmoney [ns_set get $ordersSet ColValue.[ns_urlencode discount]]]<BR>
[asmoney [ns_set get $ordersSet ColValue.[ns_urlencode tax]]]<BR>
<HR>
<STRONG>P[asmoney [ns_set get $ordersSet ColValue.[ns_urlencode total]]]</STRONG><BR>
</FONT>
</TD>
</TABLE>
</CENTER>
<BR><BR>
"

    if {![string match "" [ns_set get $ordersSet ColValue.[ns_urlencode card_no]]]} {

	if {$admin} {
	    set card_no [ns_set get $ordersSet ColValue.[ns_urlencode card_no]]
	} else {
	    set card_no {(Omitted for Security Reasons)}
	}

	append page "<CENTER>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=10>
    <TR>
        <TH>${defaultFont}Card Holder</FONT></TH>
        <TH>${defaultFont}Card</FONT></TH>
	<TH>${defaultFont}Number</FONT></TH>
        <TH>${defaultFont}Expires</FONT></TH>
    </TR>

    <TR>
        <TD>${defaultFont}[ns_set get $ordersSet ColValue.[ns_urlencode card_holder]]</FONT></TD>
        <TD>${defaultFont}[ns_set get $ordersSet ColValue.[ns_urlencode card_type]]</FONT></TD>
        <TD>${defaultFont}${card_no}</FONT></TD>
        <TD>${defaultFont}[ns_set get $ordersSet ColValue.[ns_urlencode expiry]]</FONT></TD>
    </TR>
</TABLE>
</CENTER>
<BR><BR>"
    }

    append page "<CENTER>
$defaultFont
<STRONG>Attendees:</STRONG>
</FONT>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 WIDTH=500>
<TR>
    <TD COLSPAN=2><HR></TD>
</TR>
<TR>
    <TH ALIGN=LEFT WIDTH=300>${defaultFont}Name</FONT></TH>
    <TH ALIGN=LEFT>${defaultFont}Title</FONT></TH>
</TR>
"

    foreach order_linesSet $order_linesSets {
	append page "<TR>
    <TD>${defaultFont}[ns_set get $order_linesSet ColValue.[ns_urlencode first_name]] [ns_set get $order_linesSet ColValue.[ns_urlencode last_name]]</FONT></TD>
    <TD>${defaultFont}[ns_set get $order_linesSet ColValue.[ns_urlencode title]]</FONT></TD>
</TR>"
    }

    append page "<TR>
    <TD COLSPAN=2><HR></TD>
</TR>
</TABLE>
</CENTER>
"
    return $page
}


##############################################################################
#	InitPage
##############################################################################
#
#	Websters Inc, Copyright 1997
#
#	Synopsis:	Initialize the registration result page.
#	Arguments:	form set
#	Return:		returns the initial HTML for the registration pages
#	Side Effect:	none
#	Strategy:
#
#	Author:		rlocke
#	Date:		11/27/97
#
#	History:
#		ral	11/27/97	Initial Revision
#
##############################################################################
proc InitPage {formSet} {
    #
    # Set the title for the page.
    #
    set name [ns_set get $formSet name]

    set page "<HTML>
<HEAD>
<TITLE>Executive Mall - $name : Register Now!</TITLE>
</HEAD>
<BODY BGCOLOR=\"#ffcc99\">
<A NAME=top>

<TABLE CELLSPACING=0 CELLPADDING=3 BORDER=0 WIDTH=100%>
<TR>
<TD ALIGN=\"LEFT\" VALIGN=\"TOP\">
<FONT FACE=\"verdana, arial, helvetica\" SIZE=-1 COLOR=\"#0080FF\">
<H2>$name</H2>
</FONT>
</TD>
<TD ALIGN=\"RIGHT\" VALIGN=\"TOP\">
<A HREF=\"/execmall/index.html\"><IMG SRC=\"/execmall/shared/execmalllogo.gif\" WIDTH=253 HEIGHT=78 BORDER=0 ALT=\"back to HomePage\"></A>
</TD>
</TR>
</TABLE>
<P>
<CENTER>
	<TABLE CELLSPACING=0 CELLPADDING=3 BORDER=0 WIDTH=250>
	<TR>
	<TD BGCOLOR=\"#000000\" ALIGN=center>
	<FONT FACE=\"verdana, arial, helvetica\" SIZE=-1 COLOR=\"#FFFF99\"><STRONG>
	Register Now!</STRONG></FONT></TD></TR>
	</TABLE>
</CENTER>
<P>
"

    return $page
}
