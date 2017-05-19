/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Montessori;

import java.io.Serializable;

/**
 *
 * @author nmohamed
 */
public class Grade{

    
    private String idStudent;
    private String idCrit;
    private String val;

   public String getIdStudent() {
        return idStudent;
    }

    public void setIdStudent(String idStudent) {
        this.idStudent = idStudent;
    }

    public String getIdCrit() {
        return idCrit;
    }

    public void setIdCrit(String idCrit) {
        this.idCrit = idCrit;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }
    
}
