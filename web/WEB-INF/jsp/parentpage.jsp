<%-- 
    Document   : homepage
    Created on : 24-ene-2017, 12:12:45
    Author     : nmohamed
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <%@ include file="menu.jsp" %>
        
    <head>
        <title>Home</title>

    <script type="text/javascript">
    

    
    $(document).ready( function () {
    
        //VARIABLE CUANDO HEMOS CREADO UNA LESSONS CORRECTAMENTE
        
   <%--      var lessondelete = '<%= request.getParameter("messageDelete") %>'; --%>
         
     
    $('#table_id').DataTable({
    "aLengthMenu": [[5, 10, 20, -1], [5, 10, 20, "All"]],
    "iDisplayLength": 5,
    "columnDefs": [
        {
            "targets": [ 0 ],
            "visible": false,
            "searchable": false
        }]
    });
        $('#table_datelessons').DataTable();
       
    $('#table_id tbody').on('click', 'tr', function () {
        table = $('#table_id').DataTable();
        data = table.row( this ).data();
        nameLessons = data[1];
    } );

    } );

//   
var ajax;
 
   function rowselect(LessonsSelected)
    {
        //ESTO PARA PINCHAR EN LA FILAvar LessonsSelected = data1;
        //var LessonsSelected = $(data1).html();
        //var LessonsSelected = 565;

        
        
//        if (window.XMLHttpRequest) //mozilla
//        {
//            ajax = new XMLHttpRequest(); //No Internet explorer
//        }
//        else
//        {
//            ajax = new ActiveXObject("Microsoft.XMLHTTP");
//        }
        
//ajax.onreadystatechange=funcionCallBackLessonsprogress;
 //       window.location.href = "/lessonprogress/loadRecords.htm?LessonsSelected="+LessonsSelected;
       window.open("<c:url value="/studentpage/start.htm?studentid="/>"+LessonsSelected);
//        ajax.open("POST","lessonprogress.htm?select6=loadRecords&LessonsSelected="+LessonsSelected,true);
//        ajax.send("");
  };
   
    function refresh()
    {
         location.reload();
    }
      
    
    </script>
    <style>
        .title
        {
            font-size: medium;
            font-weight: bold;
            color: gray;
            margin-top: 5px;
            padding-left: 5px;
        }
        .par
        {
            background-color: lightgrey;
            
        }
        .impar
        {
           border-bottom: solid 1px grey;
        }
        .studentDetails{
            padding-top: 5px;
            padding-bottom: 5px;
            padding-left: 10px;
        }
        .modal-header-details
        {
            background-color: #99CC66;
        }
        .modal-header-delete
        {
            background-color: #CC6666;
        }
    </style>
    </head>
    <body>
        <div class="col-xs-12">
            <div class="col-sm-12" id="maincontainer">
                <div class="col-sm-12 center-block text-center">
                    <h2><spring:message code="etiq.txtactivities"/></h2>
                </div>
            </div>
            <div class="container">
                <table id="table_id" class="display" >
                    <thead>
                        <tr>
                            <td>Studentid</td>
                            <td>Student Name</td>
                            <td>Grade Level</td>
                            
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="child" items="${children}" >
                        <tr>
                            <td>${child.id_students}</td>
                            <td>${child.nombre_students}</td>
                            <td>${child.level_id}</td>  
                        </tr>
                    </c:forEach>
                    </tbody>
            </table>
           
            </div>
        </div>
    </body>
</html>
