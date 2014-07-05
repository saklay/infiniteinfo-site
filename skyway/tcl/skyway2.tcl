# 
# skyway.tcl
#

ns_register_proc GET /skyway Skyway

proc checkCookie { conn unused_argument } {

set username [getCookie iwantcookie]
if {[string compare "" $username] != 0} {
	setCookie iwantcookie $username 2
	ns_returnredirect [ns_conn url]
} else {
	ns_returnfile 200 text/html "[ns_info pageroot]/skyway/login.adp"
}

}

proc login { } {

#login gets called whenever the customer enters his password

#check if the password is valid

#the password is valid, so set a cookie, redirect the user to another page 

#the password is invalid, redirect the user to an error page.

}

proc db_in { table fields idname id } {
#parameter table is the name of the table
#parameter fields is an ns_set
#parameter idname is the primary key of the table
#parameter id is the primary key value for this transaction

#get the size of the ns_set
set field_size [ns_set size $fields]

set params "$idname"
set values "$id"

#loop through the set and build the SQL statement
set setSize [ns_set size $fields]

for {set i 0} {$i < $setSize} {incr i} {
  set params "${params},[ns_set key $fields $i]"
  set values "${values},[ns_set value $fields $i]"
}

#get a db connection
#set db_handle [nd_db gethandle]

set sql "insert into $table (${params}) values (${values});"

ns_return 200 text/html "$sql"

#execute the SQL statement

#db connection is closed automatically by AOLServer
}

ns_register_proc POST imedia/register form_processor
proc form_processor { } {

#retrieve the session id from the cookie
set password [getCookie yabbadabbadoo]

#retrieve the fields from the form
set fields [ns_conn form]

set current_page [ns_set get $fields cp]
ns_set delkey $fields cp

if {[string compare $password ""] == 0} {
  #the user doesn't have a cookie, give him one iff this is the first page.
  if {$current_page == 0} {
    #create a ns_state to store all the data until information is complete
    set current_config [ns_set create userinfo]
    set password [ns_state_save $current_config] 
    #set the password to the ns_state's id
    setCookie yabbadabbadoo $password 1
  } else {
    ns_returnfile 200 text/html "[ns_info pageroot]/imedia/sorry.html"
  }
}

#check if the form has the yyyy field
if {[ns_set find $fields yyyy] > -1} {
  #format the date properly
  set date "[ns_set get $fields yyyy]-[ns_set get $fields mm]-[ns_set get $fields dd]"

  #remove the unecessary fields
  ns_set delkey $fields yyyy
  ns_set delkey $fields mm
  ns_set delkey $fields dd

  #insert the date_of_purchase field
  ns_set put $fields date_of_purchase $date
}

#extract the table to insert into
set table [ns_set get $fields ble]

#extract the primary key name
set pk [ns_set get $fields k]

#remove the unecessary fields
ns_set delkey $fields ble
ns_set delkey $fields k

#cycle through the set and enter the fields into the ns_state's ns_set
set current_config [ns_state_view $password]
set setSize [ns_set size $fields]
set debug_info ""
for {set i 0} {$i<$setSize} {incr i} {
  ns_set cput $current_config [ns_set key $fields $i] [ns_set value $fields $i]
  set debug_info "$debug_info [ns_set key $fields $i] = [ns_set value $fields $i]<br>"
}

#if this is the last set of info, enter into the database
if {$current_page == -1} {
  #retrieve the ns_state using the password as the state's id 
  #extract the table name, the primary key name
  #set current_config [ns_state_view $password] 
  set table [ns_set get $current_config table]
  set pk [ns_set get $current_config primary_key] 

  ns_set delkey $current_config table
  ns_set delkey $current_config primary_key

  #the primary key value is always available -- it's in the cookie! 
  #(you can always change this later, for now, let the pk_value be the ns_state's id)

  db_in $table $current_config $pk $password

} else {
  #include the table name and the primary key name
  ns_set cput $current_config table $table
  ns_set cput $current_config primary_key $pk
  ns_state_save $current_config $password

  ns_return 200 text/html "$debug_info <p><a href=\"index2.html\">continue</a>"
}
}

proc showset {anyset} {
  set anysetSize [ns_set size $anyset]
  ns_puts "The set size is $anysetSize<br>"
  for {set i 0} {$i < $anysetSize} {incr i} {
    ns_puts "<b>[ns_set key $anyset $i]</b>:[ns_set value $anyset $i]<br>"
  }
}
