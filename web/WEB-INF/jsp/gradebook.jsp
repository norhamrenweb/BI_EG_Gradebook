<%-- 
    Document   : progressdetails
    Created on : 06-abr-2017, 10:18:54
    Author     : Jesus
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
        <title>Progress Details</title>
        <script>
           $(document).ready(function(){
               var numberAttempted = $('#contenedorAttempted').children().length;
               $("#showAttempteds").html(numberAttempted+'<br><span class="glyphicon glyphicon-triangle-bottom"></span>');
               
                var table = $('#tableGradebook').DataTable({
                    paging: false,
                    searching: false,
                    ordering: false,
                    info:     false,
                    scrollY: "600px",
                    scrollX: true,
                    scrollCollapse: true,
                    columnDefs: [
                        {   "width": "200px", 
                            "targets": "_all" 
                        },
                        {   "width": "150px",
                            "className": "text-left", 
                            "targets": [ 1 ]
                        },
                        {   "className": "text-center", 
                            "targets": "_all"
                        },
                        {
                            "targets": [ 0 ],
                            "visible": false,
                            "searchable": false
                        }],
                    fixedColumns: true
                });
                $('#tableGradebook tbody')
                    .on( 'mouseenter', 'td', function () {
                        var colIdx = table.cell(this).index().column;

                        $( table.cells().nodes() ).removeClass( 'highlight' );
                        $( table.column( colIdx ).nodes() ).addClass( 'highlight' );
                    } );
                    
                    
                $( "th" ).click(function() {   
                    var idCategory = $(this).attr('id');
                    window.location.replace("<c:url value="/assignments/loadRecords.htm?ClassSelected="/>"+idCategory);
                });
                $('[data-toggle="popover"]').popover({
                    placement : 'top',
                    trigger : 'hover'
                });
                     
                $("#contenedorAttempted").on("hide.bs.collapse", function(){
                    $("#showAttempteds").html(numberAttempted+'<br><span class="glyphicon glyphicon-triangle-bottom"></span>');
                });
                $("#contenedorAttempted").on("show.bs.collapse", function(){
                  $("#showAttempteds").html(numberAttempted+'<br><span class="glyphicon glyphicon-triangle-top"></span>');
                });
                var message = '${message}';
    
     if (message === 'Student does not have lessons under the selected objective' ){
     $('#myModal').modal({
        show: 'false'
    });
     };

            });
        </script>
        <style>
            .attempted{
                color: #D0D2D3;
            }
            .containerProgress
            {
                display: table;
/*                background-color: #d9edf7;*/
                min-height: 200px;
            }
            .cellProgress
            {
                display: table-cell;
                vertical-align: middle;
                padding: 10px;
                
            }
            .spacediv
            {
                margin-top: 5px;
                margin-bottom: 5px;
            }
            .mastered
            {
                display: table;
                width: 50%;
                min-height: 100px;
                border-radius: 10px;
                background-color: #08c;
                color: white;
                font-size: xx-large;
                font-weight: bold;
            }
            #showAttempteds
            {
                background-color: transparent;
                border-width: 0px;
                border-style: none;
                border-color: transparent;
                border-image: initial;
            }
            td.highlight {
                background-color: rgba(100,100,100, 0.25) !important;
            }
            table.dataTable tbody tr :hover{
                background-color: #0a6aa1 !important;
            }

        </style>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-xs-4">
                    <label>Term:</label>
                    <select>
                        <option>Q1</option>
                        <option>Q2</option>
                        <option>Q3</option>
                    </select>
                    
                </div>
                <div class="col-xs-4"></div>
                <div class="col-xs-4">
                    <a href="<c:url value="/categories/loadCategories.htm?ClassSelected=1"/>">
                        <div class="center-block">
                            Categories
<%--                            <input type="image" src="<c:url value="/recursos/img/iconos/Calendar-01.svg"/>" data-toggle="tooltip" data-placement="top" title="View calendar">--%>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-xs-12">
            <hr> 
            </div>
            <div class="col-xs-12" id="divTableGradebook">
                <table id="tableGradebook" class="display">
                    <thead>
                        <tr>
                            <th>Student ID</th>
                            <th>Student</th>
                            <c:forEach var="p" items="${categories}" varStatus="contadorC">
                            <th id="${p.id[0]}"><span data-content="${p.weight}" data-toggle="popover" data-placement="left" data-original-title="${p.description}" data-trigger="hover">${p.name}</span></th>
                            </c:forEach>
                            <th>Gradebook Grade</th>
                            <th>Report Card Grade</th>
                        </tr>
                    </thead> 
                    <tbody>
                        <c:forEach var="s" items="${students}" varStatus="contador">
                        <tr>
                            <td>${s.id_students}</td>
                            <td>${s.nombre_students}</td>
                            
                            <c:forEach var="g" items="${grades}" varStatus="contadorG">
                                <c:if test="${categories.size()>contadorG.index}">
                                <td>${grades[contador.index][contadorG.index]}
                                    <%--<br>
${contador.index} - ${contadorG.index}--%>
                                </td>
                            </c:if>
                            </c:forEach>
                            <td>50</td>
                            <td>50</td>
                        </tr>
                        </c:forEach>
<%--                        <tr>
                            <td>2</td>
                            <td>Tiger Nixon</td>
                            <td>${grades[1][0]}</td> 
                            <td>${grades[1][1]}</td>
                            <td>50</td>
                            <td>50</td>
                        </tr>--%>
                        
                    </tbody>
                    <%--<c:forEach var="p" items="${progress}" >
                        <tr>
                            <td>${p.lesson_name}</td>
                            <td>${p.comment}</td>
                            <td>${p.comment_date}</td> 
                            <td>${p.rating}</td>
                        </tr>
                    </c:forEach>--%>
                    

                </table>

            </div>
        </div>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
 <div class="modal-dialog" role="document">
   <div class="modal-content">
     <div class="modal-header">
       <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
<!--        <h4 class="modal-title" id="myModalLabel">Modal title</h4>-->
     </div>
     <div class="modal-body text-center">
      <H1>${message}</H1>
     </div>
<!--      <div class="modal-footer">
       <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
       <button type="button" class="btn btn-primary">Save changes</button>
     </div>-->
   </div>
 </div>
</div>

    </body>
</html>
