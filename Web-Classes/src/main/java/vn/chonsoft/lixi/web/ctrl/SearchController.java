/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author Asus
 */
@WebController
@RequestMapping("Search")
public class SearchController {
    
    private static final Logger log = LogManager.getLogger(SearchController.class);
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "search", method = RequestMethod.GET)
    public ModelAndView search(Map<String, Object> model, HttpServletRequest request) {
        
        return new ModelAndView("search/search");
        
    }
    
    /**
     * 
     * @param model
     * @param keyword
     * @param request
     * @return 
     */
    @RequestMapping(value = "search", params = "search=true", method = RequestMethod.GET)
    public ModelAndView search(Map<String, Object> model, @RequestParam String keyword, HttpServletRequest request) {
        
        return new ModelAndView("search/search");
        
    }
}
