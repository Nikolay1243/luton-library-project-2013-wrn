<%@ Language=VBScript %>
		<%
	
		Session("dbpath")="\db\graceshiscores.mdb"
		Dim sqlQuery
		Dim tb
		
		sqlQuery = "select * FROM userdata ORDER by data DESC"

		set db = Server.CreateObject("ADODB.Connection") 
        	db.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & server.MapPath(Session("dbpath")) & ";"
        	db.Open 

        	Set tb = Server.CreateObject("ADODB.Recordset")    
        	tb.Open sqlQuery, db
		
 
     Dim count 
		count =1

		do until tb.EOF

			if (count >1) Then 
				response.Write("&")
			end if
			response.Write ("username")
			response.Write(count)
			response.Write("=")
			response.Write(tb.fields("FB_ID"))
			response.Write("&score")
			response.Write(count)
			response.Write("=")
			response.Write(tb.fields("data"))
			
			count =count +1
		tb.MoveNext
     loop



     tb.close
		db.close
		set tb=Nothing
		set db=Nothing

		%>