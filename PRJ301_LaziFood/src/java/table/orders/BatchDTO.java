/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.orders;

import java.util.List;

/**
 *
 * @author Kim Nha
 */
public class BatchDTO {
    private String city;
    private String district;
    private int totalOrder;
    private List<OrderDTO> listOrder;

    public BatchDTO() {
    }

    public BatchDTO(String city, String district, int totalOrder, List<OrderDTO> listOrder) {
        this.city = city;
        this.district = district;
        this.totalOrder = totalOrder;
        this.listOrder = listOrder;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public List<OrderDTO> getListOrder() {
        return listOrder;
    }

    public void setListOrder(List<OrderDTO> listOrder) {
        this.listOrder = listOrder;
    }
    
    public int getTotalOrder() {
        return totalOrder;
    }

    public void setTotalOrder(int totalOrder) {
        this.totalOrder = totalOrder;
    }
}
