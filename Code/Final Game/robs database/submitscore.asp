<%@ Language=VBScript %>

<%
Session("dbpath")="\db\graceshiscores.mdb"


dim db
dim tb

dim strUserName
dim strUserData

strUserName=Request.QueryString("user_name")
strUserData=Request.QueryString("data")


set db = Server.CreateObject("ADODB.Connection") 
db.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & server.MapPath(Session("dbpath")) & ";"
db.Open 
'Define the server object, the connection string. Open the database


sqlQuery = "select * FROM userdata WHERE FB_ID='" &strUserName &"'"
'sqlQuery = "INSERT INTO userdata(FB_ID,data) VALUES ('" &strUserName & "','" & strUserData & "' )"
'sqlQuery = "UPDATE userdata SET data = '"& strUserData &"' WHERE FB_ID='"& strUserName & "' "
'Response.Write(sqlQuery)

Set tb = Server.CreateObject("ADODB.Recordset")    
tb.Open sqlQuery, db

if (tb.EOF)Then 
		'FB_ID not found so insert to make new record
		sqlQuery = "INSERT INTO userdata(FB_ID,data) VALUES ('" &strUserName & "','" & strUserData & "' )"
Else
		'FB_ID found in table so need to update that record
		sqlQuery = "UPDATE userdata SET data = '"& strUserData &"' WHERE FB_ID='"& strUserName & "' "
End If

tb.close
'db.close
tb.Open sqlQuery, db

db.close
set tb=Nothing
set db=Nothing

'Response.Redirect("showdetails.asp")       
%>