/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Montessori;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 *
 * @author nmohamed
 */
public class Classes {
    
    private int id;
    private String name;
    private String start;
    private String finish;
    private boolean template;
    private Level level;
    private Category objective;
    private Course course;
    private String[] contentid;
    private int teacherid;
    private Criteria method;

    public Criteria getMethod() {
        return method;
    }

    public void setMethod(Criteria method) {
        this.method = method;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }
    private String comments;
  

    public List<Students> getStudents() {
        return students;
    }

    public void setStudents(List<Students> students) {
        this.students = students;
    }
    private String date;
    private List<Students> students;

    public String[] getContentid() {
        return contentid;
    }

    public int getTeacherid() {
        return teacherid;
    }

    public void setTeacherid(int teacherid) {
        this.teacherid = teacherid;
    }

    public void setContentid(String[] equipmentid) {
        this.contentid = equipmentid;
    }

    public Level getLevel() {
        return level;
    }

    public void setLevel(Level level) {
        this.level = level;
    }

    public Category getObjective() {
        return objective;
    }

    public void setObjective(Category objective) {
        this.objective = objective;
    }

    public Course getCourse() {
        return course;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getFinish() {
        return finish;
    }

    public void setFinish(String finish) {
        this.finish = finish;
    }

    

    public void setCourse(Course course) {
        this.course = course;
    }

   

  

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
   

    public boolean isTemplate() {
        return template;
    }

    public void setTemplate(boolean template) {
        this.template = template;
    }
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

   
    
    
}
