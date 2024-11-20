package product;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import table.dishes.DishesDTO;
import table.ingredients.IngredientDTO;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author long
 */
public class ShoppingCart implements Serializable {

    private HashMap<IngredientDTO, Integer> listIngredient;
    private HashMap<DishesDTO, Integer> listDish;
    private BigDecimal totalPrice;

    public ShoppingCart() {
    }

    public ShoppingCart(HashMap<IngredientDTO, Integer> listIngredient, HashMap<DishesDTO, Integer> listDish, BigDecimal totalPrice) {
        this.listIngredient = listIngredient;
        this.listDish = listDish;
        this.totalPrice = totalPrice;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public HashMap<IngredientDTO, Integer> getListIngredient() {
        return listIngredient;
    }

    public HashMap<DishesDTO, Integer> getListDish() {
        return listDish;
    }

    public void addIngredientToCart(IngredientDTO ingr, int quantity) {
        if (listIngredient == null) {
            listIngredient = new HashMap<>();
        }
        if (listIngredient.containsKey(ingr)) {
            int oldQuantity = listIngredient.get(ingr);
            listIngredient.put(ingr, oldQuantity + quantity);
        } else {
            listIngredient.put(ingr, quantity);
        }
        calculateTotalPrice();
    }

    public void addIngredientToCart(List<IngredientDTO> listIngr, int quantity) {
        for (IngredientDTO ingr : listIngr) {
            if (listIngredient == null) {
                listIngredient = new HashMap<>();
            }
            if (listIngredient.containsKey(ingr)) {
                int oldQuantity = listIngredient.get(ingr);
                listIngredient.put(ingr, oldQuantity + quantity);
            } else {
                listIngredient.put(ingr, quantity);
            }
        }
        calculateTotalPrice();
    }

    public void addDishToCart(DishesDTO dish, int quantity) {
        if (listDish == null) {
            listDish = new HashMap<>();
        }
        if (listDish.containsKey(dish)) {
            int oldQuantity = listDish.get(dish);
            listDish.put(dish, oldQuantity + quantity);
        } else {
            listDish.put(dish, quantity);
        }
        calculateTotalPrice();
    }

    public void removeIngredient(String id) {
        int ingredientId = Integer.parseInt(id);
        // Khai báo một iterator để xóa phần tử khi duyệt qua Set
        Iterator<IngredientDTO> iterator = listIngredient.keySet().iterator();
        while (iterator.hasNext()) {
            IngredientDTO ingredient = iterator.next();
            if (ingredient.getId() == ingredientId) {
                iterator.remove(); // Xóa phần tử hiện tại từ Set
                break; // Kết thúc vòng lặp sau khi tìm và xóa phần tử
            }
        }
        calculateTotalPrice();
    }

    public void removeDish(String id) {
        int dishId = Integer.parseInt(id);
        // Khai báo một iterator để xóa phần tử khi duyệt qua Set
        Iterator<DishesDTO> iterator = listDish.keySet().iterator();
        while (iterator.hasNext()) {
            DishesDTO dish = iterator.next();
            if (dish.getId() == dishId) {
                iterator.remove(); // Xóa phần tử hiện tại từ Set
                break; // Kết thúc vòng lặp sau khi tìm và xóa phần tử
            }
        }
        calculateTotalPrice();
    }

    public void updateIngredientQuantity(String id, String value) {
        int ingredientId = Integer.parseInt(id);
        int changeValue = Integer.parseInt(value);
        IngredientDTO targetIngredient = null;
        for (IngredientDTO ingredient : listIngredient.keySet()) {
            if (ingredient.getId() == ingredientId) {
                targetIngredient = ingredient;
                break;
            }
        }
        if (targetIngredient != null) {
            int currentQuantity = listIngredient.get(targetIngredient);
            int newQuantity = currentQuantity + changeValue;
            if (newQuantity > 0) {
                listIngredient.put(targetIngredient, newQuantity);
            } else {
                listIngredient.remove(targetIngredient);
            }
        }
        calculateTotalPrice();
    }
    
        public void updateDishQuantity(String id, String value) {
        int dishId = Integer.parseInt(id);
        int changeValue = Integer.parseInt(value);
        DishesDTO targetDish = null;
        for (DishesDTO dish : listDish.keySet()) {
            if (dish.getId() == dishId) {
                targetDish = dish;
                break;
            }
        }
        if (targetDish != null) {
            int currentQuantity = listDish.get(targetDish);
            int newQuantity = currentQuantity + changeValue;
            if (newQuantity > 0) {
                listDish.put(targetDish, newQuantity);
            } else {
                listDish.remove(targetDish);
            }
        }
        calculateTotalPrice();
    }
    
    
    

    public void calculateTotalPrice() {
        totalPrice = BigDecimal.ZERO; // Khởi tạo totalPrice bằng BigDecimal.ZERO

        // Tính tổng giá trị từ danh sách các nguyên liệu
        if (listIngredient != null) {
            for (IngredientDTO ingredient : listIngredient.keySet()) {
                BigDecimal ingredientPrice = ingredient.getPrice();
                int quantity = listIngredient.get(ingredient);
                BigDecimal totalIngredientPrice = ingredientPrice.multiply(BigDecimal.valueOf(quantity));
                totalPrice = totalPrice.add(totalIngredientPrice);
            }
        }

        // Tính tổng giá trị từ danh sách các món ăn
        if (listDish != null) {
            for (DishesDTO dish : listDish.keySet()) {
                BigDecimal dishPrice = dish.getPrice();
                int quantity = listDish.get(dish);
                BigDecimal totalDishPrice = dishPrice.multiply(BigDecimal.valueOf(quantity));
                totalPrice = totalPrice.add(totalDishPrice);
            }
        }
    }

}
