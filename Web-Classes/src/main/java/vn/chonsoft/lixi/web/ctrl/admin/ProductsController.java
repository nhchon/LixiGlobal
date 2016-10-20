/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.Calendar;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.LixiCategory;
import vn.chonsoft.lixi.model.VatgiaProduct;
import vn.chonsoft.lixi.model.form.InputProductForm;
import vn.chonsoft.lixi.repositories.service.LixiCategoryService;
import vn.chonsoft.lixi.repositories.service.VatgiaProductService;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author Asus
 */
@WebController
@RequestMapping(value = "/Administration/Products")
public class ProductsController {
    
    @Autowired
    private LixiCategoryService lxcSer;
    
    @Autowired
    private VatgiaProductService vgpSer;
    
    /**
     * 
     * @param model
     * @param page
     * @return 
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ModelAndView list(Map<String, Object> model, @PageableDefault(value = 50, sort = {"alive", "id"}, direction = Sort.Direction.DESC) Pageable page){
        
        Page<VatgiaProduct> pRs = this.vgpSer.findAll(page);
        
        model.put("pRs", pRs);
        
        return new ModelAndView("Administration/products/listProducts");
    }
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "input", method = RequestMethod.GET)
    public ModelAndView inputProduct(Map<String, Object> model, HttpServletRequest request){
        
        model.put("categories", this.lxcSer.findAll());
        model.put("inputProductForm", new InputProductForm());
        
        return new ModelAndView("Administration/products/inputProduct");
        
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @RequestMapping(value = "input", method = RequestMethod.POST)
    public ModelAndView inputProduct(Map<String, Object> model,
            @Valid InputProductForm form, Errors errors, HttpServletRequest request) {
        
        model.put("categories", this.lxcSer.findAll());
        
        if (errors.hasErrors()) {
            return new ModelAndView("Administration/products/inputProduct");
        }
        
        try {
            
            // TO-DO
            LixiCategory lxc = this.lxcSer.findById(form.getCategory());
            
            VatgiaProduct vgp = new VatgiaProduct();
            vgp.setCategoryId(lxc.getVatgiaId().getId());
            vgp.setCategoryName(lxc.getName());
            vgp.setName(form.getName());
            vgp.setPrice(LiXiGlobalUtils.floor2Hundred(LiXiGlobalUtils.increaseByPercent(form.getPrice(), LiXiGlobalConstants.LIXI_DEFAULT_INCREASE_PERCENT, true)));
            vgp.setImageUrl(form.getImageUrl());
            vgp.setDescription(form.getDescription());
            vgp.setLinkDetail(form.getProductSource());
            vgp.setAlive(1);
            vgp.setModifiedDate(Calendar.getInstance().getTime());
            
            this.vgpSer.save(vgp);
            
        } catch (ConstraintViolationException e) {
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("Administration/products/inputProduct");
            
        }
        
        return new ModelAndView(new RedirectView("/Administration/Products/input?success=1", true, true));
    }
}
