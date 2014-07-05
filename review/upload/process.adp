<HTML>
<HEAD>
<TITLE>Upload File</TITLE>
</HEAD>
<BODY BGCOLOR="#CCCCCC">

<%
    set url  [ns_user data [ns_conn authuser $conn]]
	ns_puts "$url"

    set rfile [lindex [split [ns_queryget clientfile] {[/\]}] end]
    set rfile [ns_normalizepath [ns_url2file $url]/upload/${rfile}]
    set lfile [ns_queryget clientfile.tmpfile]
    ns_cp $lfile $rfile
    ns_unlink $lfile 
%>

<H2>The upload was successful!</H2>

<P>Please contact our <A HREF="mailto:webmaster@infiniteinfo.com">webmaster</A> if you have any futher questions.

</BODY>
</HTML>
