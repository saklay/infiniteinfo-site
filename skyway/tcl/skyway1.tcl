#
# cart.tcl
#

proc CartUpdate { } {
    
    #
    # If the cart exists, then fetch it.  Otherwise, create
    # a new cart.
    #
    if {[set cart [CartGetCart]] == 0} {
	# Create a new cart.
	set cartId  [CartNew]
	set cartSet [ns_state_view $cartId]

	# Create a special header which sets the cookie.
	ns_updateheader Set-Cookie "cartId=$cartId; path=/;"
    } else {
	set cartId  [lindex $cart 0]
	set cartSet [lindex $cart 1]
    }

    
    #
    # Update the contents of the cart.
    #
    for {set i 0} {$i < [ns_set size $formSet]} {incr i} {
	set key   [ns_set key $formSet $i]
	set value [ns_set value $formSet $i]
	ns_set update $cartSet $key $value
	ns_set delkey $cartSet $value
    }

    ns_state_save $cartSet $cartId
    return [list $cartId $cartSet]
}


proc CartPrintContents { {cart {}} {prettyprint 0} {orderSet {}} {db {}} } {
    #
    # If the cart does not exist.
    #
    if {[string match "" $cart]} {
	if {[set cart [CartGetCart]] == 0} {
	    ns_adp_include cartempty.adp
	    return
	}
	set cartId  [lindex $cart 0]
	set cartSet [lindex $cart 1]
    } else {
	set cartId  [lindex $cart 0]
	set cartSet [lindex $cart 1]
    }

    #
    # Store the referer, but only if we aren't coming from
    # a cart page.
    #
    set refererurl [ns_set iget [ns_conn headers] referer]
    if {![string match "" $refererurl]} {
	if {![regexp "cartshow.adp" $refererurl] \
		&& ![regexp "cartupdate.adp" $refererurl]} {
	    ns_set update $cartSet refererurl $refererurl
	    ns_state_save $cartSet $cartId
	}
    }

    #
    # Check if the cart has items in it and route to
    # the appropriate page.
    #
    set empty 1
    if {[ns_set size $cartSet] != 0} {
        for {set i 0} {$i < [ns_set size $cartSet]} {incr i} {
	    if {[regexp {^[0-9]+$} [ns_set key $cartSet $i]]} {
		set empty 0
		break
	    }
	}
    }

    if {$empty} {
	ns_adp_include cartempty.adp
    } else {
	ns_adp_include cartfull.adp $cart $prettyprint $orderSet $db
    }
}


proc CartGetCart { } {
    if {[string compare "" [set cartId [CartGetId]]] == 0 || \
	    [string compare "" [set cartSet [ns_state_view $cartId]]] == 0} {
	return 0
    } else {
	return [list $cartId $cartSet]
    }
}


proc CartGetId { } {
    set cartId ""
    regexp {^cartId=(.+)} [ns_set iget [ns_conn headers] Cookie] \
	    null cartId

    return $cartId
}


proc CartNew {} {
    return [ns_state_save [ns_set new cart]]
}
