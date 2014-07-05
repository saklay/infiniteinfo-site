<HTML>
<HEAD>
<TITLE>Upload File</TITLE>
</HEAD>
<BODY BGCOLOR="#CCCCCC">

<%
    set user [ns_conn authuser $conn]
    set name [ns_user fullname $user]
    set url  [ns_user data $user]

    if {![string match "" $name]} {
        ns_puts "Welcome <STRONG>$name</STRONG>!"
    }

    if {[string match "" $url]} {
        ns_puts "<P>Sorry, but you don't have permission to upload files to our server."
    } else {
	ns_adp_include upload.adp
    }
%>

<P>Please contact our <A HREF="mailto:webmaster@infiniteinfo.com">webmaster</A> if you have any questions.

</BODY>
</HTML>