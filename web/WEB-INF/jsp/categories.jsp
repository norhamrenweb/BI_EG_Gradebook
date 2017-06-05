<%-- 
    Document   : createlesson
    Created on : 30-ene-2017, 14:59:17
    Author     : nmohamed
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>
<!DOCTYPE html>
<html>
    <%@ include file="infouser.jsp" %>
    <%@ include file="menu.jsp" %>
        
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SOW</title>
    
        <script>
$(document).ready(function(){
$('#tableCategories').DataTable();
$('#tableCategories tbody').on('click', 'tr', function () {
        table = $('#tableCategories').DataTable();
        data = table.row( this ).data();
        id = data[0];
        editCategory(data);
    } );

$("#method").on('mouseover', 'option' , function(e) {
    
        var $e = $(e.target);
    
    if ($e.is('option')) {
        $('#method').popover('destroy');
        $("#method").popover({
            animation: 'true',
            trigger: 'hover',
            placement: 'right',
            title: $e.attr("data-title"),
            content: $e.attr("data-content")
        }).popover('show');
    }
});


});

$(function () {
    $("#TextMinLetter").blur(function () {
    if ($(this).is(":invalid")) {
      $(this).popover({
                animation: 'true',
                title: $(this).attr("data-title"),
                placement: 'top'
          }).popover('show');
    }else if($(this).is(":valid")){
        $(this).popover('destroy');
    }
  });
  $("#TextMaxLetter").blur(function () {
    if ($(this).is(":invalid")) {
      $(this).popover({
                animation: 'true',
                title: $(this).attr("data-title"),
                placement: 'top'
          }).popover('show');
    }else if($(this).is(":valid")){
        $(this).popover('destroy');
    }
    var points;
    var letraMin = $("#TextMinLetter").val();
    var letraMax = $("#TextMaxLetter").val();
    
    var letters = [], i = letraMin.charCodeAt(0), j = letraMax.charCodeAt(0);
                    for (; i <= j; ++i) {
                        letters.push(String.fromCharCode(i));
                    }   
                    points = letters.length;
    
    var pointsMax = (points - 1);
    $('#valMax').append('<label>Value</label><input type="text" class="form-control text-right" size="1" value="'+pointsMax+'" readonly>');
    $('#valMin').append('<label>Value</label><input type="text" class="form-control text-right" size="1" value="0" readonly>');
  });
  $("#TextMinNumber").blur(function () {
    if ($(this).is(":invalid")) {
      $(this).popover({
                animation: 'true',
                title: $(this).attr("data-title"),
                placement: 'top'
          }).popover('show');
    }else if($(this).is(":valid")){
        $(this).popover('destroy');
    }

  });
  $("#TextMaxNumber").blur(function () {
    if ($(this).is(":invalid")) {
      $(this).popover({
                animation: 'true',
                title: $(this).attr("data-title"),
                placement: 'top'
          }).popover('show');
    }else if($(this).is(":valid")){
        $(this).popover('destroy');
    }

  });
});
            function editCategory(id)
            {
                $('#EditCategory').removeClass('hidden');
                $('#createCategory').removeClass('in');
                $('#DelCategory').val(data[0]);
                $('#nameeditcategory').val(data[1]);
                $('#descriptioneditcategory').val(data[2]);
                $('#weighteditcategory').val(data[3]);
                $('#Term1editcategory').val(data[4]);
                
            }
               //AÑADE LOS Criterias al select que se va enviar
            function addCriteria()
            {
            var name = $('#nameNewCriteria').val();
            $('#criterias').append('<option>'+name+'</option>');
            $('#nameNewCriteria').val('');
            }
             //Quita LOS Criterias al select que se va enviar
            function delCriteria()
            {
            $('#criterias option:selected').remove();
           
            }
          

            var ajax;
             function createCategory()
            {
            var range;
            var id = $("#idclass").val();
            var name = $("#namenewcategory").val();
            var description = $("#descriptionnewcat").val();
            var TypeGrading = $("#selectType option:selected").val();
            var term_selected = '';
            $("input:checkbox[name=termCat]:checked").each(function(){
            if (this.checked) {
                term_selected += $(this).val()+',';
            }
            });
            if(TypeGrading === '1'){
                var letraMin = $("#TextMinLetter").val();
                var letraMax = $("#TextMaxLetter").val();
                
                    var letters = [], i = letraMin.charCodeAt(0), j = letraMax.charCodeAt(0);
                    for (; i <= j; ++i) {
                        letters.push(String.fromCharCode(i));
                    }   
                    range = letters.toString();
            }else{
                var numberMin = $("#TextMinNumber").val();
                var numberMax = $("#TextMaxNumber").val();
                
                    var numbers = [], i = numberMin, j = numberMax;
                    for (i; i <= j; ++i) {
                        numbers.push(i);
                    }   
                    range = numbers.toString();
            };
            var term_ids = term_selected.toString().slice(0,-1);
            var grades = {name: TypeGrading,values: range};
            
            var data = {
                       name :  name,
                       description : description,
                       gradetype : grades,
                       term_ids: term_ids
                     };
            $.ajax({
                        type: "POST",
                       url: "newCategory.htm?classid="+id,
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
   
    
         
            $(function () {
                
                 $('#btnShowCreate').click(function () {
                    $('#EditCategory').addClass('hidden'); 
                });
                
            });
          
            
            
        </script>
        <style>
            textarea 
            {
                resize: none;
            }
             .popover{
                width: 500px;
            }
            .panel-body
            {
                padding: 0px;
            }
        </style>
    </head>
    <body>


        <div class="container">
            <h1 class="text-center">Categories</h1>
              <input type="hidden" class="form-control" name="TXTidcategory" id="idclass" value ="${classid}" readonly="">
            <div class="col-xs-12" id="divTableGradebook">
                <table id="tableCategories" class="display">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Categories</th>
                            <th>Description</th>
                            <th>Weight</th>
                             <c:forEach var="t" items="${terms}">
                            <th value="${t.id}">${t.name}</th>
                            </c:forEach>
                        </tr>
                    </thead> 
                    <tbody>
                        <c:forEach var="p" items="${categories}" varStatus="contadorCategories">
                            <tr>
                                <td>${p.id[0]}</td>
                                <td>${p.name}</td>
                                <td>${p.description} ${p.term_ids}</td>
                                <td>${p.weight}</td>
                                <c:forEach var="term" items="${terms}" varStatus="contadorTerm">
                            
                            <td>${term.name}<input type="checkbox" id="${p.id[0]}-${term.name}" name="${term.name}" class="checkbox-success disabled"></td>
                            <script>
                                var termsSelected${contadorCategories.count}${contadorTerm.count} = "${p.term_ids}";
                                var term${contadorCategories.count}${contadorTerm.count} = termsSelected${contadorCategories.count}${contadorTerm.count}.split(',');
                                if($.inArray("${contadorTerm.count}",term${contadorCategories.count}${contadorTerm.count}) !== -1){
                                    $('#${p.id[0]}-${term.name}').attr("checked", true);
                                }
                            </script>
                                </c:forEach>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="col-xs-12" style="margin-top: 40px;">
                <hr>
            </div>
            <div class="panel-group" >
                <div class="panel ">
                  <div class="" role="tab" id="headingOne">
                    <h4 class="">
                        <button id="btnShowCreate" data-toggle="collapse" href="#createCategory" aria-expanded="true" aria-controls="collapseOne" class="btn btn-success">
                            <span class="glyphicon glyphicon-plus-sign"></span>
                        </button>
                    </h4>
                  </div>
                  <div id="createCategory" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                    <div class="panel-body">
                        <form:form id="formCreateCategories" method ="post"  >
                            <fieldset>
                                <legend>Create category</legend>  
                                <div class="col-xs-12">
                                    <div class="col-xs-3 center-block form-group">
                                        <label class="control-label">Name new category</label>
                                        <input type="text" class="form-control" name="TXTnamenewCategory" id="namenewcategory"  placeholder="Name">
                                    </div>
                                    <div class="col-xs-7 center-block form-group">
                                        <label class="control-label">Description</label>
                                        <input type="text" class="form-control" name="TXTdescriptionnewCategory" id="descriptionnewcat"  placeholder="Description">
                                    </div>
<!--                                    <div class="col-xs-1 center-block form-group">
                                        <label class="control-label">Weight</label>
                                        <input type="number" class="form-control" name="TXTnamenewmethod" id="weightnewcat"  placeholder="0">
                                    </div>-->
                                    <div class="col-xs-1 center-block form-group paddingLabel">
                                        <input type="button" name="AddCategory" value="save" class="btn btn-success" id="Addcategory" onclick="createCategory()"/>
                                    </div>
                                </div>
                                <div class="col-xs-6 form-inline">
                                    <script>
                                    function selecType()
                                        {
                                            TypeSelected = $('#selectType').val();
                                            if(TypeSelected === '1'){
                                                $('#typeNumber').addClass('hidden');
                                                $('#typeLetter').removeClass('hidden');
                                            }else if(TypeSelected === '2'){
                                                $('#typeLetter').addClass('hidden');
                                                $('#typeNumber').removeClass('hidden');
                                            }else{
                                                $('#typeLetter').addClass('hidden');
                                                $('#typeNumber').addClass('hidden');
                                            }
                                            
                                        }
                                      
                                    </script>
                                    <div class="col-xs-6">
                                    <label>Type</label>
                                    <select class="form-control" id="selectType" onchange="selecType()">
                                        <option value="0">Select grading type</option>
                                        <option value="1">Letter</option>
                                        <option value="2">Number</option>
                                    </select>
                                    </div>
                                    
                                    <div id="typeLetter" class="col-xs-6 hidden form-group form-inline">
                                        <div class="row">
                                            <div class="col-xs-6">
                                                <label>from</label>
                                                <input type="text" id="TextMinLetter" data-title="You should enter letters caps or small from A - Z" class="form-control text-right" placeholder="A" pattern="[a-zA-Z]{1,}" maxlength="1" size="1">
                                            </div>
                                            <div class="col-xs-6" id="valMax">
                                                
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-6">
                                            <label>to</label>
                                            <input type="text" id="TextMaxLetter" data-title="You should enter letters caps or small from A - Z" class="form-control text-right" placeholder="Z" pattern="[a-zA-Z]{1,}" maxlength="1" size="1">
                                            </div>
                                            <div class="col-xs-6" id="valMin">
                                                
                                            </div>
                                        </div>
                                    </div>
                                    <div id="typeNumber" class="col-xs-6 hidden form-group form-inline">
                                        <label>from.</label>
                                        <input type="text" id="TextMinNumber" data-title="You should enter numbers from 0 - 99" class="form-control" placeholder="0" maxlength="2" pattern="[0-9]{1,}" size="2">
                                        <label>Max.</label>
                                        <input type="text" id="TextMaxNumber" data-title="You should enter numbers from 1 - 100" class="form-control" placeholder="100" maxlength="3" pattern="[0-9]{1,}" size="2">
                                        <br>
                                        
                                    </div>
                                    
                                </div>
                                <div class="col-xs-3">
                                    <label>Decial places</label>
                                    <select class="form-control" id="decimalPlaces" >
                                        <option value="0">Select decimal places</option>
                                        <option value="0">0</option>
                                        <option value="1">0.0</option>
                                        <option value="2">0.00</option>
                                    </select>
                                </div>
                                <div class="col-xs-3">
                                    <c:forEach var="t" items="${terms}">
                                    <div class="col-xs-4">
                                        <label class="control-label">${t.name}</label>
                                        <input type="checkbox" name="termCat" value="${t.id}" class="checkbox-inline checkbox-success">
                                    </div>
                                     </c:forEach>
                                </div>
                            </fieldset>
<!--                            SE COMENTA PORQUE EL BEDAYIA NO NECESITA ESTO-->
<!--                            <fieldset >
                                <legend>Add Criteria</legend>  
                                <div class="col-xs-12">
                                    <div class="col-xs-6">
                                        <div class="col-xs-10 center-block form-group">
                                            <label class="control-label">Add Critería</label>
                                            <input type="text" class="form-control" name="TXTnamenewmethod" id="nameNewCriteria"  placeholder="Name criteria">
                                        </div>
                                        <div class="col-xs-2 center-block form-group paddingLabel">
                                            <input type="button" name="AddCriteria" class="btn btn-success" value="+" onclick="addCriteria()">
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="col-xs-10 center-block form-group">
                                            <label class="control-label">Criterias añadidos</label>
                                            <select id="criterias" multiple size="10" class="input-sm col-xs-12">
                                                
                                            </select>
                                        </div>
                                        <div class="col-xs-2 center-block form-group paddingLabel">
                                            <input type="button" class="btn btn-warning" value="-" onclick="delCriteria()">
                                        </div>
                                    </div>
                                </div>
                            </fieldset> -->
                        </form:form>
                    </div>
                  </div>
                </div>
            </div>
            <div class="col-xs-12 hidden" id="EditCategory">
                <div class="col-xs-11">
                    <form:form id="formEditCategories" method ="post" action="createsetting.htm?select=createsetting" >
                        <fieldset id="formEditCategory">
                            <legend>Edit category</legend>  
                            <div class="row">
                                <div class="col-xs-3 center-block form-group">
                                    <label class="control-label">Edit category</label>
                                    <input type="text" class="form-control" name="TXTnamenewmethod" id="nameeditcategory"  placeholder="Name">
                                </div>
                                <div class="col-xs-7 center-block form-group">
                                    <label class="control-label">Description</label>
                                    <input type="text" class="form-control" name="TXTnamenewmethod" id="descriptioneditcategory"  placeholder="Description">
                                </div>
<!--                                <div class="col-xs-1 center-block form-group">
                                    <label class="control-label">Weight</label>
                                    <input type="number" class="form-control" name="TXTnamenewmethod" id="weighteditcategory"  placeholder="0">
                                </div>-->
                                <div class="col-xs-2 center-block form-group paddingLabel">
                                    <input type="button" name="editCategory" value="Edit" class="btn btn-success" id="editCategory" onclick="EditCategory()"/>
                                </div>
                            </div>
                            
                            <div class="col-xs-6 col-xs-offset-3">
                                <c:forEach var="term" items="${terms}" varStatus="contadorTerm">
                                    <div class="col-xs-4">
                                            <label class="control-label">${term.name}</label>
                                            <input type="checkbox" name="${term.id}" class="checkbox-inline checkbox-success">
                                    </div>
                                </c:forEach>
<!--                                <div class="col-xs-4">
                                    <label class="control-label">T1</label>
                                    <input type="checkbox" name="t1" class="checkbox-inline checkbox-success">
                                </div>
                                <div class="col-xs-4">
                                    <label class="control-label">T2</label>
                                    <input type="checkbox" name="t2" class="checkbox-success">
                                </div>
                                <div class="col-xs-4">
                                    <label class="control-label">T3</label>
                                    <input type="checkbox" name="t3" class="checkbox-success">
                                </div>-->
                            </div>
                            
                        </fieldset> 
                    </form:form>
                </div>
                <div class="col-xs-1 text-center">
                     <form:form id="formCreateCategories" method ="post" action="createsetting.htm?select=createsetting" >
                        <fieldset id="formCreateCategory">
                            <div class="row" style="padding-top: 30px;">
                            <legend> </legend>
                            <button id="DelCategory" class="btn btn-danger" style="margin-top: 25px;">Del</button>
                            </div>
                        </fieldset>
                     </form:form>
                </div>
            </div>
            
            </div> 
        <div id="modalConfirmeDeleteObjective">
            <!-- Modal -->
            <div class="modal fade" id="confirmedDeleteObjective" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Are you sure you want to delete this objective?</h4>
                        </div>
                        <div class="modal-body">
                            <button type="button" class="btn btn-default" data-dismiss="modal" id="" onclick="deleteObjective()">Yes</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" >No</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="modalConfirmeDeleteContent">
            <!-- Modal -->
            <div class="modal fade" id="confirmedDeleteContent" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Are you sure you want to delete this content?</h4>
                        </div>
                        <div class="modal-body">
                            <button type="button" class="btn btn-default" data-dismiss="modal" id="" onclick="deleteContent()">Yes</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" >No</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="modalConfirmeDeleteMethod">
            <!-- Modal -->
            <div class="modal fade" id="confirmedDeleteMethod" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Are you sure you want to delete this method?</h4>
                            <h1 id="methodSelectForDelete"></h1>
                        </div>
                        <div class="modal-body">
                            <button type="button" class="btn btn-default" data-dismiss="modal" id="" onclick="deleteMethod()">Yes</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" >No</button>
                        </div>
                    </div>
                </div>
            </div>
        </div> 
    </body>
</html>
