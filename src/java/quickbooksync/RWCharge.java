/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package quickbooksync;

import java.util.Date;

/**
 *
 * @author nmohamed
 */
public class RWCharge {
    
    private RWFamily rwFamily ;//family id
   private int chargeID;
   private Date date;
   private String description;
   private Double amount;
   private Date dueDate;
   private int accountingSystemId ;
   
 
   public void RWCharge() {}
  
   public int getchargeID() {
      return chargeID;
   }
   public void setchargeId( int chargeid ) {
      this.chargeID = chargeid;
   }
 
    public RWFamily getrwFamily() {
        return rwFamily;
    }
 
    public void setrwFamily(RWFamily rwfamily) {
        this.rwFamily = rwfamily;
    }
 
   
 
    
 public Date getDate() {
        return date;
    }
 
    public void setDate(Date date) {
        this.date = date;
    }
    public String getDescription() {
        return description;
    }
 
    public void setDescription(String description) {
        this.description= description;
    }
    public Double getAmount() {
        return amount;
    }
 
    public void setAmount(Double amount) {
        this.amount = amount;
    } 
    public Date getdueDate() {
        return dueDate;
    }
 
    public void setdueDate(Date duedate) {
        this.dueDate = duedate;
    }
    public int getAccountingSystemId() {
        return accountingSystemId;
    }
 
    public void setAccountingSystemId(int accountingSystemId) {
        this.accountingSystemId = accountingSystemId;
    }
    
   
}
