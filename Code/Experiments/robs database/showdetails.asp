<%@ Language=VBScript %>
<%
	Response.Expires = 0
%>
<html>
	<head>
	<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
	<%
	Session("dbpath")="\db\graceshiscores.mdb"
	%>
		
	</head>
	<body>
		

		<%
		Response.Write("<H1>Data Table</H1>")

		Dim sqlQuery
		Dim tb
		
		sqlQuery = "select * FROM userdata ORDER by FB_ID ASC"

		set db = Server.CreateObject("ADODB.Connection") 
        	db.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & server.MapPath(Session("dbpath")) & ";"
        	db.Open 

        	Set tb = Server.CreateObject("ADODB.Recordset")    
        	tb.Open sqlQuery, db
		
  		response.Write("<Table border=1>")
        
		do until tb.EOF
			response.Write("<TR><TD>")
			response.Write(tb.fields("FB_ID"))
			response.Write("</TD><TD>")
			response.Write(tb.fields("data"))
			response.Write("</TD></TR>")
			tb.MoveNext
        	loop

		response.Write("</Table>")

        	tb.close
		db.close
		set tb=Nothing
		set db=Nothing

		%>
		
		
	</body>
</html>