/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.dishes;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;
import product.Product;
import table.ingredients.IngredientDTO;

/**
 *
 * @author long
 */
public class DishesDTO extends Product implements Serializable {

    private HashMap<String, String> recipe;

    public DishesDTO() {
    }

    public DishesDTO(int id, String name, int category_id, BigDecimal price, String images, HashMap<String, String> recipe) {
        super(id, name, category_id, price, images);
        this.recipe = recipe;
    }
    
    public DishesDTO(int id, String name, int category_id, BigDecimal price, String images, boolean status, HashMap<String, String> recipe) {
        super(id, name, category_id, price, images, status);
        this.recipe = recipe;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        DishesDTO that = (DishesDTO) o;
        return id == that.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    public HashMap<String, String> getRecipe() {
        return recipe;
    }

    public void setRecipe(HashMap<String, String> recipe) {
        this.recipe = recipe;
    }
    
}
