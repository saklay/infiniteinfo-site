##############################################################################
#
#	III, Inc. 1997
#
#	Author:		Robert Locke
#	File:		review.tcl
#	Date:		10/20/97
#
#	Description:
#		Implements redirection module for Infinite Intranet.
#
#	History:
#		ral	10/20/97		Initial Revision
#
##############################################################################
ns_register_proc -noinherit GET /review Review

##############################################################################
#	Review
##############################################################################
#
#	III, Inc. 1997
#
#	Synopsis:	Redirects client to the appropriate page based on name.
#	Arguments:	connection ID, not used
#	Return:		nothing (redirects client to the appropriate page)
#	Side Effect:	none
#
#	Author:		Robert Locke
#	Date:		10/20/97
#
#	History:
#		ral	10/20/97	Initial Revision
#
##############################################################################
proc Review {conn notused} {

    #
    # Get the user's information from his/her connection data.
    #
    set user [ns_conn authuser $conn]

    #
    # Hopefully, the user's redirected URL is stored in the comment field
    # of their user record.
    #
    set url [ns_user data $user]

    #
    # Now, redirect the user.
    #
    ns_returnredirect $conn $url
}
