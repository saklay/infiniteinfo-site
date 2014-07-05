##############################################################################
#
#	Websters Inc, Copyright 1997
#
#	Author:		Robert Locke
#	File:		admin.tcl
#	Date:		11/27/97
#
#	Description:
#		Implements administration screens for the Executive Mall module.
#
#	History:
#		ral	11/27/97		Initial Revision
#
##############################################################################
ns_register_proc GET  /Admin/DownloadOrders AdminDownloadOrders
ns_register_proc POST /Admin/QueryOrders    AdminQueryOrders

##############################################################################
#	AdminDownloadOrders
##############################################################################
#
#	Websters Inc, Copyright 1997
#
#	Synopsis:	Download all orders since last download.
#	Arguments:	connection, not used
#	Return:		nothing (returns order report to client)
#	Side Effect:	none
#	Strategy:
#		Figure out our start and end order #'s
#		    start: orders.lastorder from autogen table
#		    end:   max order # in orders table
#		Update last order # in autogen table
#
#	Author:		Robert Locke
#	Date:		11/27/97
#
#	History:
#		ral	11/27/97	Initial Revision
#
##############################################################################
proc AdminDownloadOrders {conn notused} {

    #
    # AOLServer requires us to allocate all our handles in one shot.
    # Thus, we need to allocate 2 handles.  1 for determining
    # our start and end ids, and 2 for the AdminShowOrders routine.
    # (This adds up to 2 instead of 3 since we can reuse 1 handle).
    #
    set db [lindex [set dbhandles [ns_db gethandle execmall 2]] 0]

    #
    # Get our start order #.
    #
    set sql "select \
                 id + 1\
             from \
	         autogen \
             where \
                 field = 'orders.lastorder'"

    set start [ns_set value [ns_db 1row $db $sql] 0]

    #
    # Get our end order #.
    #
    set sql "select \
                 max(id) \
             from \
	         orders"

    set end [ns_set value [ns_db 1row $db $sql] 0]

    #
    # Snag the orders.
    #
    AdminShowOrders $conn $start $end $dbhandles

    #
    # Now update the autogen table.
    #
    if { [string compare "" $end] != 0 } {
	set sql "update \
		     autogen \
                 set \
                     id = $end \
                 where \
                     field = 'orders.lastorder'"

	ns_db dml $db $sql
    }

}


##############################################################################
#	AdminQueryOrders
##############################################################################
#
#	Websters Inc, Copyright 1997
#
#	Synopsis:	Query orders database showing a selected range of
#			orders.
#	Arguments:	connection, not used
#			(start/end order # as form data)
#	Return:		nothing (returns order report to client)
#	Side Effect:	none
#	Strategy:
#		Get form data and call AdminShowOrders.
#
#	Author:		Robert Locke
#	Date:		11/27/97
#
#	History:
#		ral	11/27/97	Initial Revision
#
##############################################################################
proc AdminQueryOrders {conn notused} {

    #
    # Snag our form data.
    #
    if ![getformdata $conn formSet] {
	return
    }

    #
    # Call AdminShowOrders with the start and end.
    #
    AdminShowOrders $conn [ns_set get $formSet start] \
	    [ns_set get $formSet end]

}


##############################################################################
#	AdminShowOrders
##############################################################################
#
#	Websters Inc, Copyright 1997
#
#	Synopsis:	Display order reports.
#	Arguments:	starting order_no, end order_no
#			(start/end order # as form data)
#	Return:		nothing (returns order report to client)
#	Side Effect:	none
#	Strategy:
#		Generate SQL for querying order database
#		For each order
#		    generate HTML for order_header
#		    query order_lines and add to HTML
#		Return HTML
#
#	Author:		Robert Locke
#	Date:		11/27/97
#
#	History:
#		ral	11/27/97	Initial Revision
#
##############################################################################
proc AdminShowOrders {conn start end {dbhandles {}}} {

    ns_share defaultFont

    #
    # If there are valid start and end values, create a clause.
    #
    if {[string compare "" $start] != 0} {
	set where "where id >= $start"
    }

    if {[string compare "" $end] != 0} {
	if [info exists where] {
	    set where "$where and id <= $end"
	} else {
	    set where "where id <= $end"
	}
    }

    if {![info exists where]} {
	set where {}
    }

    #
    # Set the title for the page.
    #
    set page "<HTML>
<HEAD>
<TITLE>Executive Mall - Query Orders</TITLE>
</HEAD>
<BODY BGCOLOR=\"#ffcc99\">
<CENTER>
<IMG SRC=\"/execmall/shared/execmalllogo.gif\" WIDTH=\"253\" HEIGHT=\"78\" BORDER=0 ALT=\"Executive Mall\">
<BR><BR>
<FONT FACE=\"arial, helvetica\" COLOR=\"#008000\"><EM><STRONG>
Executive Mall - Query Orders</STRONG></EM></FONT><BR><BR>
</CENTER>
"

    #
    # Query the order tables.
    #
    if {[string compare "" $dbhandles] == 0} {
	set dbhandles [ns_db gethandle execmall 2]
    }

    set dbh [lindex $dbhandles 0]
    set dbl [lindex $dbhandles 1]

    set sql "select \
                 * \
             from \
	         orders \
             $where \
             order by \
             id"

    set ordersSet [ns_db select $dbh $sql]
    set tempSet   [ns_set new tempSet]

    #
    # Process every order, looking up the individual line items in the
    # order_lines table.
    #
    while {[ns_db getrow $dbh $ordersSet]} {
	for {set i 0} {$i < [ns_set size $ordersSet]} {incr i} {
	    ns_set update $tempSet ColValue.[ns_urlencode [ns_set key $ordersSet $i]] \
		    [ns_set value $ordersSet $i]
	}

        set sql "select
                     *
                 from
	             order_lines
                 where
                     order_id = [ns_set get $ordersSet id]
                 order by
                     item_id"

	set order_linesSet [ns_db select $dbl $sql]
	set temp_linesSets {}

	while {[ns_db getrow $dbl $order_linesSet]} {
	    set temp_linesSet  [ns_set new temp_linesSet]

	    for {set i 0} {$i < [ns_set size $order_linesSet]} {incr i} {
		ns_set update $temp_linesSet ColValue.[ns_urlencode [ns_set key $order_linesSet $i]] \
			[ns_set value $order_linesSet $i]
	    }

	    lappend temp_linesSets $temp_linesSet
	}

	append orders [ShowOrderTable $tempSet $temp_linesSets 1]
    }

    #
    # If there were no orders, then say so.
    #
    if {![info exists orders]} {
	set orders "\n${defaultFont}<H2>There are no new orders.</H2></FONT>\n"
    }

    append page $orders

    append page "</BODY>
</HTML>
"

    ns_respond $conn -status 200 -type text/html -string $page
}
