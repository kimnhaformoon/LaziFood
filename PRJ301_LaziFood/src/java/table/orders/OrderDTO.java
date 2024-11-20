/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.orders;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.HashMap;
import table.dishes.DishesDTO;
import table.ingredients.IngredientDTO;

/**
 *
 * @author long
 */
public class OrderDTO {
    private int id;
    private int accountId;
    private String fullname;
    private String phone;
    private Date orderDate;
    private Date shipDate;
    private String address;
    private String city;
    private String district;
    private BigDecimal totalPrice;
    private HashMap<IngredientDTO, Integer> listIngredient;
    private HashMap<DishesDTO, Integer> listDish;
    private int status;

    public OrderDTO() {
    }

    public OrderDTO(int id, int accountId, String fullname, String phone, Date orderDate, Date shipDate, String address, String city, String district, BigDecimal totalPrice, HashMap<IngredientDTO, Integer> listIngredient, HashMap<DishesDTO, Integer> listDish, int status) {
        this.id = id;
        this.accountId = accountId;
        this.fullname = fullname;
        this.phone = phone;
        this.orderDate = orderDate;
        this.shipDate = shipDate;
        this.address = address;
        this.city = city;
        this.district = district;
        this.totalPrice = totalPrice;
        this.listIngredient = listIngredient;
        this.listDish = listDish;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

  

    public String getFullname() {
        return fullname;
    }

    public String getPhone() {
        return phone;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public Date getShipDate() {
        return shipDate;
    }

    public String getAddress() {
        return address;
    }

    public String getCity() {
        return city;
    }

    public String getDistrict() {
        return district;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public HashMap<IngredientDTO, Integer> getListIngredient() {
        return listIngredient;
    }

    public HashMap<DishesDTO, Integer> getListDish() {
        return listDish;
    }

    public int getStatus() {
        return status;
    }

    public void setId(int id) {
        this.id = id;
    }



    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public void setShipDate(Date shipDate) {
        this.shipDate = shipDate;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public void setListIngredient(HashMap<IngredientDTO, Integer> listIngredient) {
        this.listIngredient = listIngredient;
    }

    public void setListDish(HashMap<DishesDTO, Integer> listDish) {
        this.listDish = listDish;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}
