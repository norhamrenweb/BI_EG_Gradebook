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
                        {   "width": "75px", 
                            "targets": "_all" 
                        },
                        {   "className": "text-left", 
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
                    window.location.replace("<c:url value="/gradebook/loadRecords.htm?ClassSelected="/>"+idCategory);
                });
                $("#tableGradebook").on('mouseover', 'th' , function(e) {
    
        var $e = $(e.target);
    
    if ($e.is('th')) {
        $('#tableGradebook').popover('destroy');
        $("#tableGradebook").popover({
            animation: 'true',
            trigger: 'hover',
            placement: 'top',
            title: $e.attr("data-title"),
            content: $e.attr("data-content")
        }).popover('show');
    }
});
                $('[data-category="dataCategory"]').tooltip();
                
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
                background-color: grey !important;
            }
            .tooltip.top .tooltip-inner{
 
            max-width:310px;

            padding:3px 8px;

            color:#000;

            text-align:center;

            background-color:red !important;

            -webkit-border-radius:5px;

            -moz-border-radius:5px;

            border-radius:5px

            }
        </style>
    </head>
    <body>
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
                <table id="tableGradebook" class="display">
                    <thead>
                        <tr>
                            <th>Student ID</th>
                            <th>Student</th>
                            <th id="1" data-placement="top" title="Description Quizzes" content="Weight20">Quizzes</th>
                            <th id="2" data-placement="top" title="Composition Des" content="Weight40">Composition</th>
                            <th>Participation</th>
                            <th>Projects</th>
                            <th>Exam</th>
                            <th>Text</th>
                            <th>Homework</th>
                            <th>ATL</th>
                            <th>FOR</th>
                            <th>SUM</th>
                            <th>Gradebook Grade</th>
                            <th>Report Card Grade</th>
                        </tr>
                    </thead> 
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>Tiger Nixon</td>
                            <td>90</td>
                            <td>80</td>
                            <td>61</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Garrett Winters</td>
                            <td>90</td>
                            <td>80</td>
                            <td>61</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>Ashton Cox</td>
                            <td>90</td>
                            <td>80</td>
                            <td>61</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>Norhan</td>
                            <td>90</td>
                            <td>80</td>
                            <td>61</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                        </tr>
                        <tr>
                            <td>5</td>
                            <td>Jesús</td>
                            <td>90</td>
                            <td>80</td>
                            <td>61</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                        </tr>
                        <tr>
                            <td>6</td>
                            <td>Sergio</td>
                            <td>90</td>
                            <td>80</td>
                            <td>61</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                        </tr>
                        <tr>
                            <td>7</td>
                            <td>Javier</td>
                            <td>90</td>
                            <td>80</td>
                            <td>61</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                        </tr>
                        <tr>
                            <td>8</td>
                            <td>Carola</td>
                            <td>90</td>
                            <td>80</td>
                            <td>61</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                        </tr>
                        <tr>
                            <td>9</td>
                            <td>Mauricio</td>
                            <td>90</td>
                            <td>80</td>
                            <td>61</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                        </tr>
                        <tr>
                            <td>10</td>
                            <td>Marisa</td>
                            <td>90</td>
                            <td>80</td>
                            <td>61</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                            <td>70</td>
                            <td>50</td>
                            <td>50</td>
                        </tr>
                        
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
