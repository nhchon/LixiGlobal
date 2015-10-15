/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.config;

import javax.servlet.FilterRegistration;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.RequestContextFilter;
import org.springframework.web.servlet.DispatcherServlet;

/**
 *
 * @author chonnh
 */
public class Bootstrap implements WebApplicationInitializer{
    
    @Override
    public void onStartup(ServletContext container) throws ServletException{

        container.getServletRegistration("default").addMapping("/resource/*");
        //
        AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
        rootContext.register(RootContextConfiguration.class);
        container.addListener(new ContextLoaderListener(rootContext));
        //
        AnnotationConfigWebApplicationContext servletContext = new AnnotationConfigWebApplicationContext();
        servletContext.register(WebServletContextConfiguration.class);
        ServletRegistration.Dynamic dispatcher = container.addServlet("springDispatcher", new DispatcherServlet(servletContext));
        dispatcher.setLoadOnStartup(1);
        //MultipartConfigElement(location, maxFileSize, maxRequestSize, fileSizeThreshold)
        dispatcher.setMultipartConfig(new MultipartConfigElement(
                null, 20_971_520L, 41_943_040L, 512_000
        ));
        dispatcher.addMapping("/");
        // Restful services
        AnnotationConfigWebApplicationContext restContext =
                new AnnotationConfigWebApplicationContext();
        restContext.register(RestServletContextConfiguration.class);
        DispatcherServlet servlet = new DispatcherServlet(restContext);
        servlet.setDispatchOptionsRequest(true);
        dispatcher = container.addServlet(
                "springRestDispatcher", servlet
        );
        dispatcher.setLoadOnStartup(2);
        dispatcher.addMapping("/services/Rest/*");
        
        /* encoding filter*/
        FilterRegistration.Dynamic fr = container.addFilter("encodingFilter",
                new CharacterEncodingFilter());
        fr.setInitParameter("encoding", "UTF-8");
        fr.setInitParameter("forceEncoding", "true");
        fr.addMappingForUrlPatterns(null, false, "/*");
        
        // requestContextFilter
        //container.addFilter("requestContextFilter", new RequestContextFilter()).addMappingForUrlPatterns(null, false, "/*");
    }
}
