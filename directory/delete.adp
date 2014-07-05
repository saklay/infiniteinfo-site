<% ns_adp_bind_args id %>
<FORM METHOD="POST" ACTION="totally_delete.adp">
<FONT FACE="verdana, helvetica, times new roman" SIZE=-1 COLOR="#000000">
<% ns_puts "<input type=\"hidden\" name=\"id\" value=$id>" %>
Are you sure you want to delete this entry?
<BR><BR>
&nbsp;&nbsp;<INPUT TYPE="submit" NAME="yes" VALUE="Yes">&nbsp;&nbsp;<INPUT TYPE="button" NAME="no" VALUE="No" onClick="location.href='index.adp'">
</FONT>
</FORM>