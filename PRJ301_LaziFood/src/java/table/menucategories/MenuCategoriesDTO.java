/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.menucategories;

/**
 *
 * @author long
 */
public class MenuCategoriesDTO {
    private int id;
    private String name;

    public MenuCategoriesDTO() {
    }

    public MenuCategoriesDTO(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }
   
}
