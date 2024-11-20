/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import product.Product;
import table.dishes.DishesDAO;
import table.dishes.DishesDTO;
import table.ingredients.IngredientDAO;
import table.ingredients.IngredientDTO;

/**
 *
 * @author long
 */
public class ViewProductDetailServlet extends HttpServlet {

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
        String type = request.getParameter("type");
        if (type == null || type.isEmpty()) {
            type = "Dish";
        }
        if (!type.equals("Dish") && !type.equals("Ingredient")) {
            type = "Dish";
        }
        String txtProductId = request.getParameter("txtProductId");
        if (txtProductId == null || txtProductId.isEmpty()) {
            txtProductId = "1";
        }
        int productId;
        try {
            productId = Integer.parseInt(txtProductId);
        } catch (Exception e) {
            productId = 1;
        }

        try (PrintWriter out = response.getWriter()) {
            if (type.equals("Dish")) {
                DishesDAO dishDao = new DishesDAO();
                DishesDTO dish = dishDao.getDishById(productId);
                request.setAttribute("product", dish);
                dishDao.getRecipeOfDish(dish);
                IngredientDAO ingrDao = new IngredientDAO();
                ingrDao.getIngredientsOfDish(dish);
                request.setAttribute("LIST_RELATED_PRODUCT", ingrDao.getList());
                request.setAttribute("numberOfSold", dishDao.countOrderOfProduct(dish));

            }
            if (type.equals("Ingredient")) {
                IngredientDAO ingrDao = new IngredientDAO();
                IngredientDTO ingredient = ingrDao.getIngredientById(productId);
                request.setAttribute("product", ingredient);
                ingrDao.getRelatedProduct(ingredient);
                request.setAttribute("LIST_RELATED_PRODUCT", ingrDao.getList());
                request.setAttribute("numberOfSold", ingrDao.countOrderOfProduct(ingredient));
            }
            request.setAttribute("type", type);
            request.getRequestDispatcher("productdetail.jsp").forward(request, response);
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
            Logger.getLogger(ViewProductDetailServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ViewProductDetailServlet.class.getName()).log(Level.SEVERE, null, ex);
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
