/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package product;

import java.math.BigDecimal;

/**
 *
 * @author long
 */
public class Product {
    protected int id; 
    protected String name; 
    protected int category_id; 
    protected BigDecimal price;
    protected String image;
    protected boolean status;

    public Product() {
    }

    public Product(int id, String name, int category_id, BigDecimal price, String image) {
        this.id = id;
        this.name = name;
        this.category_id = category_id;
        this.price = price;
        this.image = image;
    }
    
    public Product(int id, String name, int category_id, BigDecimal price, String image, boolean status) {
        this.id = id;
        this.name = name;
        this.category_id = category_id;
        this.price = price;
        this.image = image;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getCategory_id() {
        return category_id;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public String getImage() {
        return image;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public void setImage(String image) {
        this.image = image;
    }
    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
            
}
