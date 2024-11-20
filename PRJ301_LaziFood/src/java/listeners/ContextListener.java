/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listeners;

import java.util.Properties;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import utils.PropertiesFileUtil;

/**
 * Web application lifecycle listener.
 *
 * @author long
 */
public class ContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        // lấy đường dẫn các file properties qua parameter của context scope
        String siteMapLocation = 
                context.getInitParameter("SITEMAP_PROPERTIES_FILE_LOCATION");
        String authentication = 
                context.getInitParameter("AUTHENTICATION_PROPERTIES_FILE_LOCATION");
        String administrator = 
                context.getInitParameter("ADMINISTRATOR_PROPERTIES_FILE_LOCATION");
        // load các file properties lên bằng cách dùng PropertiesFileUtil
        Properties siteMapProperty = 
                PropertiesFileUtil.getProperties(context,siteMapLocation);
        Properties authenticationProperty = 
                PropertiesFileUtil.getProperties(context,authentication);
        Properties administratorProperty = 
                PropertiesFileUtil.getProperties(context,administrator);
        // set các properties object vào vùng nhớ context scope để cho các resource 
        // có thể reference 
        context.setAttribute("SITE_MAP", siteMapProperty);
        context.setAttribute("AUTHENTICATION_LIST", authenticationProperty);
        context.setAttribute("ADMINISTRATOR", administratorProperty);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
