/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.ingredients;

import product.Product;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Objects;

/**
 *
 * @author long
 */
public class IngredientDTO extends Product implements Serializable {
    private String unit;
    public IngredientDTO() {
    }

    public IngredientDTO(int id, String name, int category_id, BigDecimal price,String unit, String image) {
        super(id, name, category_id, price, image);
        this.unit = unit;
    }

    public IngredientDTO(int id, String name, int category_id, BigDecimal price,String unit, String images, boolean status) {
        super(id, name, category_id, price, images, status);
        this.unit = unit;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        IngredientDTO that = (IngredientDTO) o;
        return id == that.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
    
}
