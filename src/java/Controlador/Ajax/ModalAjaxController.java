///*
// * To change this license header, choose License Headers in Project Properties.
// * To change this template file, choose Tools | Templates
// * and open the template in the editor.
// */
//package Controlador.Ajax;
//
//import Modelo.Archivo;
//import Modelo.Lessons;
//import Modelo.Students;
//import java.util.ArrayList;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import org.springframework.web.servlet.ModelAndView;
//import org.springframework.web.servlet.mvc.Controller;
//
///**
// *
// * @author Jesus
// */
//public class ModalAjaxController implements Controller{
//
//    @Override
//    public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
//        ModelAndView mv = new ModelAndView("modalAjax");
//        Lessons lesson = new Lessons(request.getServletContext());
//        Archivo file = new Archivo(request.getServletContext());
//        Students student = new Students(request.getServletContext());
//        ArrayList<Students> students = new ArrayList<>();
//        int idLessons = Integer.parseInt(request.getParameter("idLesson"));
//        String tagClose = request.getParameter("etiqClose");
//        String tagStart = request.getParameter("etiqStart");
//        String tagEnd = request.getParameter("etiqEnd");
//        String tagFile = request.getParameter("etiqFile");
//        String tagLevel = request.getParameter("etiqLevel");
//        String tagSubject = request.getParameter("etiqSubject");
//        String tagSubsection = request.getParameter("etiqSubsection");
//        String string="";
//        
//        
//        
//        lesson.getOneLesson(idLessons);
//        file.getFile(idLessons);
//        students = student.getStudentsFromLesson(idLessons);
//        
//        string="<div class=\"modal-header\">";
//        string+= "<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>";
//        string+="<h4 class=\"modal-title\" id=\"myModalLabel\" data-idLessonsVal=" + lesson.getId_lessons() + ">" + lesson.getNombre_lessons() + "</h4>";
//        string+="</div>";
//        
//        string+="<div class=\"modal-body\">";
//        string+="<div class=\"row\">";
//        string+="<div class=\"col-xs-3\"><strong>" + tagStart + ":</strong></div>";
//        string+="<div class=\"col-xs-6\">" + lesson.getFecha_inicio() + "</div></div>";
//        string+="<div class=\"row\">";
//        string+="<div class=\"col-xs-3\"><strong>" + tagEnd + ":</strong></div>";
//        string+="<div class=\"col-xs-6\">" + lesson.getFecha_fin() + "</div></div>";
//        
//        if(file.getNombre_archivo().compareTo("")!=0){
//            string+="<div class=\"row\">";
//            string+="<div class=\"col-xs-3\"><strong>" + tagFile + ":</strong></div>";
//            string+="<div class=\"col-xs-6 nombreArchivo\">" + file.getNombre_archivo() + "</div></div>"; 
//        }
//        string+="<div class=\"row\">";
//        string+="<div class=\"col-xs-3\" data-levelVal=" + lesson.getId_level() + "><strong>" + tagLevel + ":</strong></div>";
//        string+="<div class=\"col-xs-6 nombreLevel\">" + lesson.getNombre() + "</div></div>";
//        string+="<div class=\"row\">";
//        string+="<div class=\"col-xs-3\" data-subjectVal=" + lesson.getId_subject() + "><strong>" + tagSubject + ":</strong></div>";
//        string+="<div class=\"col-xs-6 nombreSubject\">" + lesson.getNombre_subject() + "</div></div>";
//        string+="<div class=\"row\">";
//        string+="<div class=\"col-xs-3\" data-subsectionVal=" + lesson.getId_subsection() + "><strong>" + tagSubsection + ":</strong></div>";
//        string+="<div class=\"col-xs-6 nombreSubsection\">" + lesson.getNombre_subsection() + "</div></div>";
//        string+="<div class=\"col-xs-12\">LIST OF STUDENTS</div>";
//        
//        if(!students.isEmpty()){
//            for (Students stu: students){
//                string+="<div class=\"row\">";
//                string+="<div class=\"col-xs-3\" data-subsectionVal=" + stu.getId_students() + "><strong></strong></div>";
//                string+="<div class=\"col-xs-6 nombreSubsection\">" + stu.getNombre_students() + "</div></div>";
//            }
//        }
//        
//        string+="</div>";
//        string+="<div class=\"modal-footer\">";
//        string+="<button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">" + tagClose + "</button>";
//        string+="</div>";
//        
//        mv.addObject("details", string);
//        //mv.addObject("listamateriales", this.getMateriales());
//        
//        return mv;
//    }
//    
//}
