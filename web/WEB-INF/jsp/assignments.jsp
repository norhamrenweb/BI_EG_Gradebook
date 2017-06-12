<%-- 
    Document   : assignments
    Created on : 16-may-2017, 11:52:14
    Author     : Jesus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <%@ include file="menu.jsp" %>
        <title>Assignments</title>
        <script>
            var gradesPrevious = new Array();
            var ajax;
            
            
           $(document).ready(function(){
            if  ($.isNumeric(${gradevalues[0]})  ){
            var sizeGrades = ${fn:length(gradevalues)};
            var pattern = '[${gradevalues[0]}-'+sizeGrades+']'; 

            
            $('.grade').attr(
                    {
                'pattern': pattern,
                'title' : "values from 1 to 8"
            });
            }else{
            var sizeGrades = "${gradevalues}";
            var c = sizeGrades.replace(/,/gi, "|");
            var pattern = c; 

            
            $('.grade').attr(
                    {
                'pattern': pattern,
                'title' : "Letters from"+c[0]+" to"+c[5]+"a"
            });  
            };
            
            var userLang = navigator.language || navigator.userLanguage;
        $('#dateStart').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: userLang.valueOf(),
            daysOfWeekDisabled: [0, 6]
        });
        
        $('#dateEnd').datetimepicker({
            
            format: 'YYYY-MM-DD',
            locale: userLang.valueOf(),
            daysOfWeekDisabled: [0, 6]
        });
        
        $("#dateStart").on("dp.change", function (e) {
            $('#dateEnd').data("DateTimePicker").minDate(e.date);
        });       
        
        $("#dateEnd").on("dp.change", function (e) {
            $('#dateStart').data("DateTimePicker").maxDate(e.date);
        });
        var termSelected = $("#TermSelected").val();
        
        //AÑADE EL TERM AL CREATE ASSIGMENT
         $("#CreateAssigTermSelected").val(termSelected);
        
        
                var table = $('#tableAssignments').DataTable({
                    paging: false,
                    searching: false,
                    ordering: false,
                    info:     false,
                    scrollY: "600px",
                    scrollX: true,
                    scrollCollapse: true,
                    columnDefs: [
                        
                        {   "width": "10%",
                            "className": "text-left",
                            "targets": [ 1 ]
                        },
                        {   "width": "40%",
                            "className": "text-center", 
                            "targets": '_all'
                        },
                        {
                            "targets": [ 0 ],
                            "visible": false,
                            "searchable": false
                        }]
                });
                
                    
                $('select.selectpicker').selectpicker();
                
                $( "th" ).click(function() {   
                    var idAssigment = $(this).attr('id');
                    var name = $(this).find('#nameAssig').text();
                    var description = $(this).find('#nameAssig').data('description');
                    var stardate = $(this).find('#nameAssig').data('startdate');
                    var finishdate = $(this).find('#nameAssig').data('finishdate');
                    var term = $('#TermSelected option:selected').text();
                    $('#EditAssigTermSelected').val(term);
                    $('#nameEditAssignment').val(name);
                    $('#descriptionEditAssignment').val(description);
                    $('#TXTEditdateStart').val(stardate);
                    $('#TXTEditdateEnd').val(finishdate);
                    $('#delAssigment').val(idAssigment);
                    $('#buttomModalEdit').click();
                    
                    <%---window.location.replace("<c:url value="/assignments/loadRecords.htm?ClassSelected="/>"+idCategory);---%>
                });
                $('[data-toggle="popover"]').popover({
                    placement : 'top',
                    trigger : 'hover'
                });
                     
                $(".selectFaces").msDropdown();
                //CREO UN ARRAY CON LOS VALORES INICIALES
                
                $('.grade').each(function(){ // loop in to the input's wrapper

                    var obj = {
                    idStudent :  $(this).attr('data-idStudent'),
                    assignmentid :  $(this).attr('data-idAssigment'),
                    idCrit :  $(this).attr('data-idCriteria'),// place the url in a new object
                    val : $(this).val() // place the name in a new object
                  };
                gradesPrevious.push(obj);

                });
                gradesOri = JSON.stringify(gradesPrevious);
            });
        function  changeTerm(){
            termSelected = $("#TermSelected").val();
            $("#CreateAssigTermSelected").val(termSelected);
        }
        function editAssignment(){
          var name = document.getElementById("nameEditassignment").value;
    var dscrp = document.getElementById("descriptionEditassignment").value;
    var start = document.getElementById("TXTdateStartedit").value;
    var finish = document.getElementById("TXTdateEndedit").value;
    var catid = document.getElementById("idcategoryedit").value;
    var data = {
               name :  name,
               description :dscrp,
                start : start,
                 finish :  finish
             };
     $.ajax({
                        type: "POST",
                        url: "editAssign.htm?catid="+catid,
                        data: JSON.stringify(data),
                        datatype:"json",
                        contentType: "application/json",  

                        success: function(data) {
                            if(data !== ""){ // if true (1)
                             setTimeout(function(){// wait for 5 secs(2)
                                  location.reload(); // then reload the page.(3)
                             }, 5000); 
                          }
                            
                            //display(data);
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                                console.log(xhr.status);
                                   console.log(xhr.responseText);
                                   console.log(thrownError);
                               }

                    });    
    
    }
function addAssigment(){
    var name = document.getElementById("nameNewAssignment").value;
    var dscrp = document.getElementById("descriptionNewAssignment").value;
    var start = document.getElementById("TXTdateStart").value;
    var finish = document.getElementById("TXTdateEnd").value;
    var catid = document.getElementById("idcategory").value;
     var data = {
               name :  name,
               description :dscrp,
                start : start,
                 finish :  finish
             };
      $.ajax({
                        type: "POST",
                        url: "saveAssign.htm?catid="+catid,
                        data: JSON.stringify(data),
                        datatype:"json",
                        contentType: "application/json",  

                        success: function(data) {
                            if(data !== ""){ // if true (1)
                             setTimeout(function(){// wait for 5 secs(2)
                                  location.reload(); // then reload the page.(3)
                             }, 5000); 
                          }
                            
                            //display(data);
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                                console.log(xhr.status);
                                   console.log(xhr.responseText);
                                   console.log(thrownError);
                               }

                    });        

    }

var o = new Array();//{"items":[]}; // create an object with key items to hold array
    
   
    function save()
    {
            o = new Array();//{"items":[]}; // create an object with key items to hold array
            var hayInvalid = 0;
            
                
           $('.grade').each(function(){ // loop in to the input's wrapper
               if ($(this).is(":invalid")) {
                    alert("Invalid value");
                    hayInvalid = hayInvalid + 1;
                }
               
               var obj = {
               idStudent :  $(this).attr('data-idStudent'),
               assignmentid :  $(this).attr('data-idAssigment'),
               idCrit :  $(this).attr('data-idCriteria'),// place the url in a new object
               val : $(this).val() // place the name in a new object
             };

             o.push(obj);

           });
            
            if (hayInvalid === 0) {
                 $('#saveGrades').prop('disabled', false);
                  
                }else{
                 $('#saveGrades').prop('disabled', true); 
                }    
          // $('#console').text(JSON.stringify(o));// strigify to show
           gradesModi = JSON.stringify(o);
       

    }



    function sendgrades()
    {
//        alert(gradesPrevious);
//        alert(o);
         var diff = new Array();   
//        if(gradesOri !== gradesModi) {
           $.each(o, function(i, item) {
               if(gradesPrevious[i].idStudent === o[i].idStudent && gradesPrevious[i].idAssigment === o[i].idAssigment && gradesPrevious[i].idCrit === o[i].idCrit && gradesPrevious[i].val !== o[i].val){
                   diff.push(item); 
            }
            });
            var mierda = JSON.stringify(diff);
            alert(mierda);
            
//        }
        
             $.ajax({
                        type: "POST",
                        url: "saveRecords.htm",
                        data: mierda,
                        datatype:"json",
                        contentType: "application/json",  

                        success: function(data) {
                        console.log("success:",data);
                            
                            //display(data);
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                                console.log(xhr.status);
                                   console.log(xhr.responseText);
                                   console.log(thrownError);
                               }

                    });
        
    } 
    function delAssigment(){
      $('#divDelAssigment').addClass('hidden');
      $('#divConfirmAssigment').removeClass('hidden');
    }
    function CancelDelAssigment(){
      $('#divConfirmAssigment').addClass('hidden');
      $('#divDelAssigment').removeClass('hidden');
    }
//    CancelDelAssigment
    function ConfirmDelAssigment(){
       var name = document.getElementById("namededitassignment").value;
       $.ajax({
                        type: "POST",
                        url: "saveAssign.htm?catid="+catid,
                        data: JSON.stringify(data),
                        datatype:"json",
                        contentType: "application/json",  

                        success: function(data) {
                            if(data !== ""){ // if true (1)
                             setTimeout(function(){// wait for 5 secs(2)
                                  location.reload(); // then reload the page.(3)
                             }, 5000); 
                          }
                            
                            //display(data);
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                                console.log(xhr.status);
                                   console.log(xhr.responseText);
                                   console.log(thrownError);
                               }

                    });      
    }

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
/*                border: grey solid thin;*/
            }
            .cellCriteria{
                padding: 0px !important;
            }
            input{
                box-sizing: border-box;
                -webkit-appearance:none ;
            }
            input:valid {
                background-color: lightgray;
                
            }
            input:invalid {
                background-color: red !important;
            }
            .flotante {
                position: sticky;
            }
            .contenedorSave
            {
                padding-top: 200px;
            }
            .unStyle
            {
                text-align: right;
                background-color: transparent !important;
                outline: none !important;
                box-shadow: none;
                border: none;
            }
           
        </style>
    </head>
    <body>
      
            
        <div class="container">
            <div class="row" id="console">
                
            </div>
            <div class="row">
                <div class="col-xs-4">
                    <label>Term:</label>
                    <select id="TermSelected" onchange="changeTerm()">
                        <option>Q1</option>
                        <option>Q2</option>
                        <option selected>Q3</option>
                    </select>
                    
                </div>
                <div class="col-xs-4">

                </div>
                <div class="col-xs-4">
                    <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal" id="buttomModalAdd">
                        Add Assigment
                    </button>
                    <button type="button" class="btn btn-primary btn-lg hidden" data-toggle="modal" data-target="#ModalEditAssigment" id="buttomModalEdit">
                        Edit Assigment
                    </button>
                </div>
            </div>
            <div class="col-xs-12">
            <hr> 
            </div>
            <div class="col-xs-10" id="divTableGradebook">
                <table id="tableAssignments" class="display cell-border" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Student ID</th>
                            <th>Student</th>
                            <c:forEach var="assig" items="${assignments}" varStatus="contadorAssig">
                            <th class="text-center" id="${assig.id[0]}">
                                <div class="col-xs-12" id="nameAssig" data-description="${assig.description}" data-startdate="${assig.start}" data-finishdate="${assig.finish}">${assig.name}</div>
                                <%--<c:forEach var="crit" items="${criterias}">
                                    <div class="col-xs-6 celda">${crit.name}</div>
                                </c:forEach>--%>
                            </th>
                            </c:forEach>
<!--                            <th></th>-->
                        </tr>
                    </thead> 
                    <tbody>
                        <c:forEach var="stud" items="${students}" varStatus="contadorStud">
                        <tr>
                            <td>${stud.id_students}</td>
                            <td>${stud.nombre_students}</td>
                            <c:forEach var="assig" items="${assignments}" varStatus="contadorAssig">
                                <td class="text-center">
                                    <c:forEach var="critGrad" items="${criterias}" varStatus="contadorCrit">  
                                        <div class="col-xs-12 celda">

                                            <input class="grade" data-idStudent="${stud.id_students}" data-idAssigment="${assig.id[0]}" data-idCriteria="${critGrad.id[0]}" onchange="save()" type="text" width="100%" value="${grades[contadorStud.index][contadorAssig.index][contadorCrit.index]}"/>
                                        </div>
                                    </c:forEach>
                                </td>    
                            </c:forEach>
<%--                                <td>
                                    <select class="selectFaces" name="payments" style="width:250px;">
                                        <option value="" data-description="">Select grade</option>
                                        <option value="Happy" data-image="<c:url value="/recursos/img/iconos/faceHappy.svg" />" data-description="">Happy</option>
                                        <option value="Normal" data-image="<c:url value="/recursos/img/iconos/faceNormal.svg" />" data-description="" selected="true">Normal</option>
                                        <option value="Unhappy" data-image="<c:url value="/recursos/img/iconos/faceUnhappy.svg" />" data-description="">Unhappy</option>
                                    </select>  
                                </td>--%>
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
            <div class="col-xs-2 contenedorSave">
                <button id="saveGrades" class="unStyle" onclick="sendgrades()"><img src="<c:url value="/recursos/img/iconos/saveGrades.svg"/>"></button>
            </div> 
        </div>      

            <!-- Modal Create Assigment-->
             <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Create Assigment</h4>
                        </div>
                        <div class="modal-body" id="modal-CreateAssigment">
                            <form:form id="formCreateAssigment" method ="post" action="createsetting.htm?select=createsetting" >
                                <fieldset> 
                                        <div class="col-xs-6 center-block form-group">
                                            <label class="control-label">Category</label>
                                             <input type="hidden" class="form-control" name="TXTidcategory" id="idcategory" value ="${category.id[0]}" readonly="">
                                            <input type="text" class="form-control" name="TXTnamecategory" id="nameaddassignment" value ="${category.name}" readonly="">
                                        </div>
                                        <div class="col-xs-6 center-block form-group">
                                            <label class="control-label">Term</label>
                                            <input type="text" class="form-control" name="TXTnamenewmethod" id="CreateAssigTermSelected" readonly="">
                                        </div>
                                </fieldset>
                                <fieldset> 
                                        <div class="col-xs-4 center-block form-group">
                                            <label class="control-label">Assigment</label>
                                            <input type="text" class="form-control" name="TXTnamenewmethod" id="nameNewAssignment"  placeholder="Name">
                                        </div>
                                        <div class="col-xs-8 center-block form-group">
                                            <label class="control-label">Description</label>
                                            <input type="text" class="form-control" name="TXTnamenewmethod" id="descriptionNewAssignment"  placeholder="Description">
                                        </div>
<!--                                        <div class="col-xs-1 center-block form-group">
                                            <label class="control-label">Points</label>
                                            <input type="number" class="form-control" name="TXTnamenewmethod" id="weighteditcategory"  placeholder="0">
                                        </div>-->
                                </fieldset>
                                <fieldset> 
                                     <div class="col-xs-6 center-block form-group">
                                         <label class="control-label">Start Assigment</label>
                                            <div class='input-group date' id='dateStart'>
                                                <input type='text' name="TXTdateStart" id="TXTdateStart" class="form-control"/>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-xs-6 center-block form-group">
                                            <label class="control-label">End Assigment</label>
                                            <div class='input-group date' id='dateEnd'>       
                                                <input type='text' name="TXTdateEnd" id="TXTdateEnd" class="form-control" />
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </div>
                                </fieldset>
                                <fieldset>
                                    <div class="col-xs-6 center-block form-group">
                                        <label class="control-label">EL assigment tiene los siguientes criterias heredados de la categoria</label>
                                        <c:forEach var="crit" items="${criterias}">
                                            <div class="col-xs-12">${crit.name}</div>
                                        </c:forEach>
                                    </div>
                                </fieldset>
                                <fieldset>
                                <div class="col-xs-12 center-block form-group text-right">
                                    <input type="button" name="AddCategory" value="save" data-dismiss="modal" class="btn btn-success" id="AddAssigment" data-target=".bs-example-modal-lg" onclick="addAssigment()"/>
                                </div>
                                </fieldset>
                            </form:form>
                        </div>
<!--                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>-->
                    </div>
                </div>
            </div>
            <!-- Modal Edit Assigment-->
             <div class="modal fade" id="ModalEditAssigment" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Edit Assigment</h4>
                        </div>
                        <div class="modal-body" id="modal-CreateAssigment">
                            
                                <fieldset> 
                                        <div class="col-xs-6 center-block form-group">
                                            <label class="control-label">Category</label>
                                             <input type="hidden" class="form-control" name="TXTidcategory" id="idcategory" value ="${category.id[0]}" readonly="">
                                            <input type="text" class="form-control" name="TXTnamecategory" id="namecategory" value ="${category.name}" readonly="">
                                        </div>
                                        <div class="col-xs-6 center-block form-group">
                                            <label class="control-label">Term</label>
                                            <input type="text" class="form-control" name="EditAssigTermSelected" id="EditAssigTermSelected" readonly="">
                                        </div>
                                </fieldset>
                                <fieldset> 
                                        <div class="col-xs-4 center-block form-group">
                                            <label class="control-label">Assigment</label>
                                            <input type="text" class="form-control" name="TXTnamenewmethod" id="nameEditAssignment"  placeholder="Name">
                                        </div>
                                        <div class="col-xs-8 center-block form-group">
                                            <label class="control-label">Description</label>
                                            <input type="text" class="form-control" name="TXTnamenewmethod" id="descriptionEditAssignment"  placeholder="Description">
                                        </div>
<!--                                        <div class="col-xs-1 center-block form-group">
                                            <label class="control-label">Points</label>
                                            <input type="number" class="form-control" name="TXTnamenewmethod" id="weighteditcategory"  placeholder="0">
                                        </div>-->
                                </fieldset>
                                <fieldset> 
                                     <div class="col-xs-6 center-block form-group">
                                         <label class="control-label">Start Assigment</label>
                                            <div class='input-group date' id='dateStart'>
                                                <input type='text' name="TXTdateStartedit" id="TXTEditdateStart" class="form-control"/>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-xs-6 center-block form-group">
                                            <label class="control-label">End Assigment</label>
                                            <div class='input-group date' id='dateEnd'>       
                                                <input type='text' name="TXTdateEnd" id="TXTEditdateEndedit" class="form-control" />
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </div>
                                </fieldset>
                                <fieldset>
<%--                                    <div class="col-xs-6 center-block form-group">
                                        <label class="control-label">EL assigment tiene los siguientes criterias heredados de la categoria</label>
                                        <c:forEach var="crit" items="${criterias}">
                                            <div class="col-xs-12">${crit.name}</div>
                                        </c:forEach>
                                    </div>--%>
                                </fieldset>
                                <fieldset>
                                <div class="col-xs-6 center-block form-group text-right">
                                    <input type="button" name="AddCategory" value="edit" data-dismiss="modal" class="btn btn-success" id="AddAssigment" data-target=".bs-example-modal-lg" onclick="editAssignment()"/>
                                </div>
                                <div class="col-xs-6 center-block form-group text-right" id="divDelAssigment">
                                    <button type="button" name="DelAssigment" class="btn btn-danger" value="0" id="delAssigment" data-target=".bs-example-modal-lg" onclick="delAssigment()">
                                        Delete
                                    </button>
                                </div>
                                    <div class="col-xs-6 center-block form-group text-right hidden" id="divConfirmAssigment">
                                    <div class="col-xs-6 center-block form-group text-right">
                                        <button type="button" name="ConfirmDelAssigment" class="btn btn-danger" value="0" id="ConfirmDelAssigment" onclick="ConfirmDelAssigment()">
                                        Confirm
                                        </button>
                                    </div>
                                    <div class="col-xs-6 center-block form-group text-right">
                                        <button type="button" name="CancelDelAssigment" class="btn btn-success" value="0" id="CancelDelAssigment" onclick="CancelDelAssigment()">
                                        Cancel
                                        </button>
                                    </div>
                                </div>
                                </fieldset>
                            
                        </div>
<!--                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>-->
                    </div>
                </div>
            </div>
          
    </body>
</html>
