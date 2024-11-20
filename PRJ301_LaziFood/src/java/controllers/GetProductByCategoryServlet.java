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
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import table.dishes.DishesDAO;
import table.ingredients.IngredientDAO;

/**
 *
 * @author long
 */
public class GetProductByCategoryServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws javax.naming.NamingException
     * @throws java.sql.SQLException
     * @throws java.lang.ClassNotFoundException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");

        String type = request.getParameter("type");
        if (type == null || type.isEmpty()) {
            type = "Dish";
        }
        if (!type.equals("Dish") && !type.equals("Ingredient")) {
            type = "Dish";
        }
        String txtCategoryId = request.getParameter("txtCategoryId");
        if (txtCategoryId == null || txtCategoryId.isEmpty()) {
            txtCategoryId = "1";
        }
        int categoryId = 0;
        try {
            categoryId = Integer.parseInt(txtCategoryId);
        } catch (Exception e) {
            response.sendRedirect("viewProductDetailAction");
        }

        String txtIndex = request.getParameter("txtIndex");
        int index = 0;
        if (txtIndex == null || txtIndex.isEmpty()) {
            txtIndex = "1";
        }
        try {
            index = Integer.parseInt(txtIndex);
        } catch (Exception e) {
            response.sendRedirect("viewProductDetailAction");
        }
        
        try (PrintWriter out = response.getWriter()) {
            if (type.equals("Ingredient")) {
                IngredientDAO ingrDao = new IngredientDAO();
                int count = ingrDao.getTotalIngredient(categoryId);
                int pageNum = count / 20;
                if (count % 20 != 0) {
                    pageNum++;
                }
                request.setAttribute("categoryId", categoryId);
                request.setAttribute("index", index);
                request.setAttribute("pageNum", pageNum);
                ingrDao.getIngredientsByCategoryId(categoryId,index);
                request.setAttribute("LIST_PRODUCT", ingrDao.getList());
            } else if (type.equals("Dish")) {
                DishesDAO dishDao = new DishesDAO();
                int count = dishDao.getTotalDish(categoryId);
                int pageNum = count / 20;
                if (count % 20 != 0) {
                    pageNum++;
                }
                
                request.setAttribute("categoryId", categoryId);
                request.setAttribute("index", index);
                request.setAttribute("pageNum", pageNum);
                dishDao.getDishesByCategoryId(categoryId,index);
                request.setAttribute("LIST_PRODUCT", dishDao.getList());
            }
            request.getRequestDispatcher("homepage.jsp").forward(request, response);
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
        } catch (NamingException ex) {
            Logger.getLogger(GetProductByCategoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(GetProductByCategoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(GetProductByCategoryServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (NamingException ex) {
            Logger.getLogger(GetProductByCategoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(GetProductByCategoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(GetProductByCategoryServlet.class.getName()).log(Level.SEVERE, null, ex);
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
