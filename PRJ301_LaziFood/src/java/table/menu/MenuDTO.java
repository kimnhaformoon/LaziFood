/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.menu;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import table.dishes.DishesDTO;

/**
 *
 * @author long
 */
public class MenuDTO {
    private int id;
    private String name;
    private int categoryId;
    private String image;
    private String description;
    private HashMap<Integer, HashMap<Integer, List<DishesDTO>>> details;
    private boolean status;
    public MenuDTO() {
    }

    public MenuDTO(int id, String name, int categoryId, String image, String description, HashMap<Integer, HashMap<Integer, List<DishesDTO>>> details) {
        this.id = id;
        this.name = name;
        this.categoryId = categoryId;
        this.image = image;
        this.description = description;
        this.details = details;
    }
    
    public MenuDTO(int id, String name, int categoryId, String image, String description, boolean status, HashMap<Integer, HashMap<Integer, List<DishesDTO>>> details) {
        this.id = id;
        this.name = name;
        this.categoryId = categoryId;
        this.image = image;
        this.description = description;
        this.status = status;
        this.details = details;
    }

    public HashMap<Integer, HashMap<Integer, List<DishesDTO>>> getDetails() {
        return details;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public void setDetails(HashMap<Integer, HashMap<Integer, List<DishesDTO>>> details) {
        this.details = details;
    }
  
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
