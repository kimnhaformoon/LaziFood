/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import product.ShoppingCart;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import table.dishes.DishesDAO;
import table.dishes.DishesDTO;
import table.ingredients.IngredientDAO;
import table.ingredients.IngredientDTO;

/**
 *
 * @author long
 */
public class AddToCartServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String productId = request.getParameter("productId");
            String type = request.getParameter("type");
            String quantity = request.getParameter("quantity");
            
            if (productId != null && !productId.isEmpty()) {
                
                HttpSession session = request.getSession(true);
                ShoppingCart cart = (ShoppingCart) session.getAttribute("CART");
                
                if (cart == null) {
                    cart = new ShoppingCart();
                }
                
                if (type.equals("Ingredient")) {
                    IngredientDAO ingrDao = new IngredientDAO();
                    IngredientDTO ingrDto
                            = ingrDao.getIngredientById(Integer.parseInt(productId));
                    cart.addIngredientToCart(ingrDto, Integer.parseInt(quantity));
                } 
                else if (type.equals("Dish")) {
                    String isCooked = request.getParameter("cooked");
                    DishesDAO dishDao = new DishesDAO();
                    DishesDTO dishDto = dishDao.getDishById(Integer.parseInt(productId));
                    
                    if (isCooked.equals("true")) {
                        cart.addDishToCart(dishDto, Integer.parseInt(quantity));
                    } else {
                        IngredientDAO ingrDao = new IngredientDAO();
                        ingrDao.getIngredientsOfDish(dishDto);
                        cart.addIngredientToCart(ingrDao.getList(), Integer.parseInt(quantity));
                    }
                }
                session.setAttribute("CART", cart);
            }
            else {
                response.sendRedirect("cartPage");
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(AddToCartServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(AddToCartServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
