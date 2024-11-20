/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.customerplans;

import java.util.HashMap;
import java.util.List;
import table.dishes.DishesDTO;

/**
 *
 * @author long
 */
public class CustomerPlanDTO {

    private int id;
    private int accountId;
    private String name;
    private HashMap<Integer, HashMap<Integer, List<DishesDTO>>> details;

    public CustomerPlanDTO() {
    }

    public CustomerPlanDTO(int id, int accountId, String name, HashMap<Integer, HashMap<Integer, List<DishesDTO>>> details) {
        this.id = id;
        this.accountId = accountId;
        this.name = name;
        this.details = details;
    }

    

    public int getId() {
        return id;
    }

    public int getAccountId() {
        return accountId;
    }

    public HashMap<Integer, HashMap<Integer, List<DishesDTO>>> getDetails() {
        return details;
    }

    public void setDetails(HashMap<Integer, HashMap<Integer, List<DishesDTO>>> details) {
        this.details = details;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    

}
