# TCL Cookie API
# July 5, 1999
# Victor Torres II
# usage: 
#  getCookie [name]
#   [name] if name is not specified, an ns_set of all cookie names and values is returned, otherwise, the value of the cookie named name is returned.
#   returns: "" if there is no such cookie named name or if the ns_set is empty
#

#  setCookie name value expires path
#   expires defaults to 0, meaning at the end of the current browser session
#   expires is in terms of hours.  passing 4 would mean the cookie will expire in 4 hours 
#   path defaults to "/"
#

#  deleteCookie name
#   updates the headers by setting the value of the cookie named name to null and setting the expiration date to a point in time before now.
#

proc getCookie {{name ""}} {

  # read the http header
  set headerSet [ns_conn headers]
  set cookies [ns_set get $headerSet Cookie]

  # cookies are separated by a semicolon immediately followed by a space.  the last cookie has no such delimiter at the end
  # e.g. name1=value1; name2=value2
  # ns_puts "cookie string: <b>$cookies</b><br>"

  if {[string compare $cookies ""]==0} {
    return ""
  }

  # $cookies is a string containing 
  set cookie_list [split $cookies "; "]
  # ns_puts "cookie list: <b>$cookie_list</b><br>"

  #get the number of elements of the cookie_list
  set cookie_list_length [llength $cookie_list]
  # ns_puts "<b>cookie list length: $cookie_list_length</b>"

  #create an ns_set called cookie set
  set cookie_set [ns_set create cookie_set]

  #get only the odd numbered values -- the split cannot exactly split using "; " I've tried everything!
  for {set i 0} {$i<=$cookie_list_length} {set i [expr $i + 2]} {
    set name_value_pair [split [lindex $cookie_list $i] =]
    ns_set update $cookie_set [lindex $name_value_pair 0] [lindex $name_value_pair 1]
  }

  if {[string compare $name ""]!=0} {
    #return the value of the specific cookie
    return [ns_set get $cookie_set $name]
    #ns_puts "cookie name:$name<br>cookie value:[ns_set get $cookie_set $name]<br>"
  } else {
    #return the ns_set itself
    #set cookieSetSize [ns_set size $cookie_set]
    #ns_puts "<p>Cookie Set:<br>"
    #for {set i 0} {$i<$cookieSetSize} {incr i} {
    #  set k [ns_set key $cookie_set $i]
    #  set v [ns_set value $cookie_set $i]
    #  ns_puts "cookie name:\"$k\"<br>cookie value:\"$v\"<br>"
    #}
    return $cookie_set
  }
}

proc setCookie {name value {expires 0} {path "/"}} {
  if {$expires == 0} {
    set estring ""
  } else {
    set estring "expires=[ns_httptime [expr [expr [expr $expires * 60] * 60] + [ns_time]]]; "
  }
  ns_set put [ns_conn outputheaders] "Set-Cookie" "$name=$value; ${estring}path=$path;"
}

proc deleteCookie {name} {
  ns_updateheader Set-Cookie "$name=null; expires=Mon, 05-Jul-1999 00:00:00 GMT; path=/;" 
}
