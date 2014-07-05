##############################################################################
#
#	Websters Inc, Copyright 1998
#
#	Author:		Robert Locke
#	File:		admin.tcl
#	Date:		8/27/98
#
#	Description:
#	    Creates overview screen for seminars.
#
#	History:
#		ral	8/27/98		Initial Revision
#
##############################################################################
ns_register_proc GET /Seminar Seminar

##############################################################################
#	Seminar
##############################################################################
#
#	Websters Inc, Copyright 1998
#
#	Synopsis:	Provide a seminar section.
#	Arguments:	connection, not used
#	Return:		nothing (returns overview page to client)
#	Side Effect:	none
#
#	Author:		Robert Locke
#	Date:		8/27/98
#
#	History:
#		ral	8/27/98		Initial Revision
#
##############################################################################
proc Seminar {conn notused} {

    #
    # Get the seminar title encoded in the URL.
    #
    if ![getformdata $conn formSet] {
	return
    }

    set title [ns_set get $formSet title]

    #
    # Snag the section to return, based on the second field of the URL.
    #
    set section [lindex [ns_conn urlv $conn] 1]

    #
    # Find the specific seminar in our database.
    # Add an early bird column for use by the registration module.
    # 
    set db [ns_db gethandle]
    set seminar [ns_db 0or1row $db \
            "select *, (startdate1 - '@ 1 month'::reltime)::timestamp earlybird from seminars where title = [ns_dbquotevalue $title]"]

    #
    # If there is not matching seminar, return an error.
    #
    if { [string match "" $seminar] } {
	ns_returnerror $conn 400 "Could not locate seminar: $title"
	return
    }

    #
    # Dispatch the seminar to the appropriate procedure.
    #
    switch $section {
	overview    {SeminarOverview $conn $seminar $db}
	registernow {SeminarRegister $conn $seminar $db}
	default     {SeminarDefault  $conn $seminar $section $db}
    }
}


##############################################################################
#	SeminarButtons
##############################################################################
#
#	Websters Inc, Copyright 1998
#
#	Synopsis:	Provide buttons for a seminar.
#	Arguments:	connection, not used
#	Return:		nothing
#	Side Effect:	none
#
#	Author:		Robert Locke
#	Date:		8/27/98
#
#	History:
#		ral	8/27/98		Initial Revision
#
##############################################################################
proc SeminarButtons {seminar section} {

    set title [ns_set get $seminar title]

    set buttons {}

    foreach field {overview outline testimonials whyattend whoattend speaker registernow} {
	switch $field {
	    outline     {set alt "Course Outline"}
	    whyattend   {set alt "Why Attend"}
	    whoattend   {set alt "Who Attend"}
	    registernow {set alt "Register Now!"}
	    default     {set alt "[string toupper [string range $field 0 0]][string range $field 1 end]"}
	}

	if { [string match "speaker" $field] } {
	    set dbfield speaker1
	} else {
	    set dbfield $field
	}

	if { [string match "registernow" $field] || ![string match "" [ns_set get $seminar $dbfield]] } {
	    append buttons "<TR>
		<TD>"

	    if { ![string match $section $field] } {
		append buttons "
		<A HREF=\"/Seminar/$field?title=[ns_urlencode $title]\" onMouseOver=\"highlight('$field','/execmall/shared/')\" onMouseOut=\"unhighlight('$field','/execmall/shared/')\";>"
		set on {}
	    } else {
		set on {2}
	    }

	    append buttons "
	<IMG SRC=\"/execmall/shared/${on}bt${field}.gif\" NAME=\"$field\" VSPACE=2 WIDTH=152 HEIGHT=20 BORDER=0 ALT=\"$alt\">"

	    if { ![string match $section $field] } {
		append buttons "</A>"
	    }

	    append buttons "</TD></TR>\n"

	}
    }

    return $buttons
}


##############################################################################
#	SeminarVenues
##############################################################################
#
#	Websters Inc, Copyright 1998
#
#	Synopsis:	Provide venues for a seminar.
#	Arguments:	connection, not used
#	Return:		nothing
#	Side Effect:	none
#
#	Author:		Robert Locke
#	Date:		8/27/98
#
#	History:
#		ral	8/27/98		Initial Revision
#
##############################################################################
proc SeminarVenues {seminar db} {

    #
    # Set up the venue of the event.
    #
    set venues {}
    for {set i 1} {$i <= 5} {incr i} {
	if { ![string match "" [set startdate [ns_set get $seminar startdate${i}]]] } {
	    set startmonth [string range [ns_parsesqltimestamp month $startdate] 0 2]
	    set startday   [ns_parsesqltimestamp day $startdate]

	    set endmonth [string range [ns_parsesqltimestamp month [set enddate [ns_set get $seminar enddate${i}]]] 0 2]
	    set endday   [ns_parsesqltimestamp day $enddate]
	    # I think it's pretty safe to assume that seminars won't span years.
	    set endyear  [ns_parsesqltimestamp year $enddate]

	    if [string match $startmonth $endmonth] {
		if [string match $startday $endday] {
		    set dates "$startmonth $startday, $endyear"
		} else {
		    set dates "$startmonth $startday - $endday, $endyear"
		}
	    } else {
		set dates "$startmonth $startday - $endmonth $endday, $endyear"
	    }
	    
	    set venue [ns_set get $seminar venue${i}]

	    set fullvenue [ns_db 0or1row $db \
		    "select * from venues where name = [ns_dbquotevalue $venue]"]

	    #
	    # If there is not matching seminar, return an error.
	    #
	    if { [string match "" $fullvenue] } {
		set address "UNKNOWN"
	    } else {
		set address {}
		foreach field {address address2 city province country} {
		    if { ![string match "" [set value [ns_set get $fullvenue $field]]] } {
			append address $value ", "
		    }
		}
		regsub {, $} $address "" address
	    }
	    
	    append venues "\n<CENTER><STRONG><FONT FACE=\"verdana, arial, helvetica\" COLOR=\"#006699\" SIZE=-1>[string toupper $venue]</FONT></STRONG><BR></CENTER>
        <FONT FACE=\"arial, helvetica\" SIZE=-1><STRONG>DATE: </STRONG>$dates<BR>
        <STRONG>VENUE: </STRONG>$address</FONT><HR>"
	}
    }
    regsub {<HR>$} $venues "" venues

    return $venues
}
