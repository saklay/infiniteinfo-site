##############################################################################
#
#	Websters Inc, Copyright 1996
#
#	Author:		Robert Locke
#	File:		util.tcl
#	Date:		11/25/96
#
#	Description:
#	    Some utility procedures used by the mall.  I guess this could
#	    be included in a completely separate utility module.
#
#	History:
#		ral	11/25/96	Initial Revision
#
##############################################################################

##############################################################################
#	sreverse
##############################################################################
#
#	Websters Inc, Copyright 1996
#
#	Synopsis:	Reverses a string
#	Arguments:	string
#	Return:		string with elements in reverse order
#
#	Author:		Robert Locke
#	Date:		11/25/96
#
#	History:
#		ral	11/25/96	Initial Revision
#
##############################################################################
proc sreverse {string} {

    for {set i [expr [string length $string]-1]} \
	    {$i >= 0} {incr i -1} {
	append result [string index $string $i]
    }
    return $result
}


##############################################################################
#	asmoney
##############################################################################
#
#	Websters Inc, Copyright 1996
#
#	Synopsis:	Displays a number as money.
#	Arguments:	amount as number (ie, 12345.678)
#	Return:		amount as money  (ie, 12,345.68)
#	Strategy:	Reverse the string, add a comma at every 3rd digit,
#			then re-reverse the string.
#       Note:		No particular denomination is assumed.
#
#	Author:		Robert Locke
#	Date:		11/25/96
#
#	History:
#		ral	11/25/96	Initial Revision
#
##############################################################################
proc asmoney {amount} {
    regsub -all {([0-9][0-9][0-9])} \
	    [sreverse [format {%.2f} $amount]] {\1,} amount
    return [sreverse [string trimright $amount ,]]
}