<%-- 
    Document   : assignments
    Created on : 16-may-2017, 11:52:14
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
        <title>Assignments</title>
        <script>
           $(document).ready(function(){
    
                var table = $('#tableAssignments').DataTable({
                    paging: false,
                    searching: false,
                    ordering: false,
                    info:     false,
                    scrollY: "600px",
                    scrollX: true,
                    scrollCollapse: true,
                    columnDefs: [
                        
                        {   "width": "150px",
                            "className": "text-left",
                            "targets": [ 1 ]
                        },
                        {   "width": "auto",
                            "className": "text-center", 
                            "targets": "_all"
                        },
                        {
                            "targets": [ 0 ],
                            "visible": false,
                            "searchable": false
                        }]
                });
//                $('#tableAssignments tbody')
//                    .on( 'mouseenter', 'td', function () {
//                        var colIdx = table.cell(this).index().column;
//
//                        $( table.cells().nodes() ).removeClass( 'highlight' );
//                        $( table.column( colIdx ).nodes() ).addClass( 'highlight' );
//                    } );
                    
                $('select.selectpicker').selectpicker();    
                $( "th" ).click(function() {   
                    var idCategory = $(this).attr('id');
                    window.location.replace("<c:url value="/assignments/loadRecords.htm?ClassSelected="/>"+idCategory);
                });
                $('[data-toggle="popover"]').popover({
                    placement : 'top',
                    trigger : 'hover'
                });
                     
           
  

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
            table.dataTable.display tbody tr.child {
                background: white;
            }
            table.dataTable.display tbody tr table tr:hover {
                background: none;
            }
            .celda{
                box-sizing: border-box;
                padding: 0px;
                border: grey solid thin;
            }
            .cellCriteria{
                padding: 0px !important;
            }
            input{
                box-sizing: border-box;
            }
            input:valid {
                background-color: green;
            }
            input:invalid {
                background-color: red;
            }
            .flotante {
                display:scroll;
                    position:fixed;
                    bottom:200px;
                    right:200px;
            }
            select#grade option[value="good"]   { background-image:url(<c:url value="/recursos/img/iconos/faceHappy.png"/>;)   }
            select#grade option[value="normal"] { background-image:url(<c:url value="/recursos/img/iconos/faceUnhappy.png"/>;) }
            select#grade option[value="bad"] { background-image:url(<c:url value="/recursos/img/iconos/faceUnhappy.png"/>;) }
        </style>
    </head>
    <body>
        <div class="span2">
            <p><button id="saveGrades" class="btn btn-xs flotante"><img src="<c:url value="/recursos/img/iconos/saveGrades.svg"/>"></button>
            </p>
        </div>
        <div class="container">
            <div class="col-xs-12">
                <div class="col-xs-4">
                    <label>Term:</label>
                    <select>
                        <option>Q1</option>
                        <option>Q2</option>
                        <option>Q3</option>
                    </select>
                    
                </div>
               
            </div>
            <div class="col-xs-12">
            <hr> 
            </div>
            <div class="col-xs-12" id="divTableGradebook">
                <table id="tableAssignments" class="display">
                    <thead>
                        <tr>
                            <th>Student ID</th>
                            <th>Student</th>
                            <c:forEach var="assig" items="${assignments}" varStatus="contadorAssig">
                            <th class="text-center">
                                <div class="col-xs-12">${assig.name}</div>
                                <c:forEach var="crit" items="${criterias}">
                                    <div class="col-xs-6 celda">${crit.name}</div>
                                </c:forEach>
                            </th>
                            </c:forEach>
                        </tr>
                    </thead> 
                    <tbody>
                        <c:forEach var="stud" items="${students}" varStatus="contadorStud">
                        <tr>
                            <td>${stud.id_students}</td>
                            <td>${stud.nombre_students}</td>
                            <c:forEach var="assig" items="${assignments}" varStatus="contadorAssig">
                            <c:forEach var="grad" items="${grades}" varStatus="contadorGrades">
                                <c:if test="${assignments.size()>contadorGrades.index}">
                                <td class="text-center">
                                    Stud: ${contadorStud.index}
                                    <c:forEach var="critGrad" items="${criterias}" varStatus="contadorCrit">
                                    <div class="col-xs-6 celda">
                                        ${grad[contadorStud.index][contadorAssig.index]}
                                    </div>
                                    </c:forEach>
                                </td>
                                </c:if>   
                             </c:forEach>     
                            </c:forEach>
                        </tr>
                        </c:forEach>  
                        <%--<tr>
                            <td>1</td>
                            <td>Pepe</td>
                            <td>
                                <div class="col-xs-3 celda">
                                    <input type="number" width="100%" min="0" max="10"/>
                                </div>
                                <div class="col-xs-3 celda">
                                    <input type="number" width="100%" min="0" max="10"/>
                                </div>
                                <div class="col-xs-3 celda">
                                    <input type="number" width="100%" min="0" max="10"/>
                                </div>
                                <div class="col-xs-3 celda">
                                    <input type="number" width="100%" min="0" max="10"/>
                                </div>
                            </td>
                            <td>
                                <div class="col-xs-4 celda">
                                    <input type="text" pattern="[A-F]{1}" maxlength="1" size="2"/>
                                </div>
                                <div class="col-xs-4 celda">
                                    <input type="text" pattern="[A-F]{1}" maxlength="1" size="2"/>
                                </div>
                                <div class="col-xs-4 celda">
                                    <input type="text" pattern="[A-F]{1}" maxlength="1" size="2"/>
                                </div>
                            </td>
                            <td>
                                <div class="col-xs-6 celda">
                                    <select id="" class="selectpicker">
                                        <option data-thumbnail="<c:url value="/recursos/img/iconos/faceHappy.png"/>" selected="true"></option>
                                        <option data-thumbnail="<c:url value="/recursos/img/iconos/faceNormal.png"/>"></option>
                                        <option data-thumbnail="<c:url value="/recursos/img/iconos/faceUnhappy.png"/>"></option>
                                    </select>
                                </div>
                                <div class="col-xs-6 celda"></div>
                            </td>
                            <%--<td>${s.id_students}</td>
                            <td>${s.nombre_students}</td>
                            
                            <c:forEach var="g" items="${grades}" varStatus="contadorG">
                                <c:if test="${categories.size()>contadorG.index}">
                                <td>${grades[contador.index][contadorG.index]}
                                    <br>
${contador.index} - ${contadorG.index}
                                </td>
                            </c:if>
                            </c:forEach>
                            <td>50</td>
                            <td>50</td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>Pepe</td>
                            <td>
                                <div class="col-xs-3 celda">
                                    <input type="number" width="100%" min="0" max="10"/>
                                </div>
                                <div class="col-xs-3 celda">
                                    <input type="number" width="100%" min="0" max="10"/>
                                </div>
                                <div class="col-xs-3 celda">
                                    <input type="number" width="100%" min="0" max="10"/>
                                </div>
                                <div class="col-xs-3 celda">
                                    <input type="number" width="100%" min="0" max="10"/>
                                </div>
                            </td>
                            <td>
                                <div class="col-xs-4 celda">
                                    <input type="text" pattern="[A-F]{1}" maxlength="1" size="2"/>
                                </div>
                                <div class="col-xs-4 celda">
                                    <input type="text" pattern="[A-F]{1}" maxlength="1" size="2"/>
                                </div>
                                <div class="col-xs-4 celda">
                                    <input type="text" pattern="[A-F]{1}" maxlength="1" size="2"/>
                                </div>
                            </td>
                            <td>
                                <div class="col-xs-6 celda">
                                    <select id="" class="selectpicker">
                                        <option>Select...</option>
                                        <option value="1" data-thumbnail="<c:url value="/recursos/img/iconos/faceHappy.png"/>" selected="true"> </option>
                                        <option value="2" data-thumbnail="<c:url value="/recursos/img/iconos/faceNormal.png"/>"> </option>
                                        <option value="3" data-thumbnail="<c:url value="/recursos/img/iconos/faceUnhappy.png"/>"> </option>
                                    </select>
                                </div>
                                <div class="col-xs-6 celda"></div>
                            </td>
                            <%--<td>${s.id_students}</td>
                            <td>${s.nombre_students}</td>
                            
                            <c:forEach var="g" items="${grades}" varStatus="contadorG">
                                <c:if test="${categories.size()>contadorG.index}">
                                <td>${grades[contador.index][contadorG.index]}
                                    <br>
${contador.index} - ${contadorG.index}
                                </td>
                            </c:if>
                            </c:forEach>
                            <td>50</td>
                            <td>50</td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>Pepe</td>
                            <td>
                                <div class="col-xs-3 celda">
                                    <input type="number" width="100%" min="0" max="10"/>
                                </div>
                                <div class="col-xs-3 celda">
                                    <input type="number" width="100%" min="0" max="10"/>
                                </div>
                                <div class="col-xs-3 celda">
                                    <input type="number" width="100%" min="0" max="10"/>
                                </div>
                                <div class="col-xs-3 celda">
                                    <input type="number" width="100%" min="0" max="10"/>
                                </div>
                            </td>
                            <td>
                                <div class="col-xs-4 celda">
                                    <input type="text" pattern="[A-F]{1}" maxlength="1" size="2"/>
                                </div>
                                <div class="col-xs-4 celda">
                                    <input type="text" pattern="[A-F]{1}" maxlength="1" size="2"/>
                                </div>
                                <div class="col-xs-4 celda">
                                    <input type="text" pattern="[A-F]{1}" maxlength="1" size="2"/>
                                </div>
                            </td>
                            <td>
                                <div class="col-xs-6">
                                    <select id="" class="selectpicker">
                                        <option>Select...</option>
                                        <option value="1" data-thumbnail="<c:url value="/recursos/img/iconos/faceHappy.png"/>" selected="true"> </option>
                                        <option value="2" data-thumbnail="<c:url value="/recursos/img/iconos/faceNormal.png"/>"> </option>
                                        <option value="3" data-thumbnail="<c:url value="/recursos/img/iconos/faceUnhappy.png"/>"> </option>
                                    </select>
                                </div>
                                <div class="col-xs-6 celda"></div>
                            </td>
                            <%--<td>${s.id_students}</td>
                            <td>${s.nombre_students}</td>
                            
                            <c:forEach var="g" items="${grades}" varStatus="contadorG">
                                <c:if test="${categories.size()>contadorG.index}">
                                <td>${grades[contador.index][contadorG.index]}
                                    <br>
${contador.index} - ${contadorG.index}
                                </td>
                            </c:if>
                            </c:forEach>
                            <td>50</td>
                            <td>50</td>
                        </tr>--%>
                        <%--</c:forEach>--%>
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
            <select id="" class="selectpicker">
                <option>Select...</option>
                <option value="1" data-thumbnail="<c:url value="/recursos/img/iconos/faceHappy.png"/>" selected="true">Happy</option>
                <option value="2" data-thumbnail="<c:url value="/recursos/img/iconos/faceNormal.png"/>">Normal</option>
                <option value="3" data-thumbnail="<c:url value="/recursos/img/iconos/faceUnhappy.png"/>">Unhappy</option>
            </select>
        </div>
                    
    </body>
</html>
