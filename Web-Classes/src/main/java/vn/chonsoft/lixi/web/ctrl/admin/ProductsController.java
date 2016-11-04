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
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.LixiCategory;
import vn.chonsoft.lixi.model.VatgiaProduct;
import vn.chonsoft.lixi.model.form.InputProductForm;
import vn.chonsoft.lixi.repositories.service.LixiCategoryService;
import vn.chonsoft.lixi.repositories.service.VatgiaCategoryService;
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
    
    private static final Logger log = LogManager.getLogger(ProductsController.class);
    
    @Autowired
    private LixiCategoryService lxcSer;
    
    @Autowired
    private VatgiaProductService vgpSer;
    
    @Autowired
    private VatgiaCategoryService vgcSer;
    
    /**
     * 
     * @param model
     * @param id
     * @param active
     * @return 
     */
    @RequestMapping(value = "activate", method = RequestMethod.POST)
    public ModelAndView activateProduct(Map<String, Object> model, @RequestParam Integer id, @RequestParam Integer active){
        
        VatgiaProduct p = this.vgpSer.findById(id);
        p.setAlive(active);
        
        this.vgpSer.save(p);
        
        return new ModelAndView(new RedirectView("/Administration/Products/list?paging.page=1&paging.sort=alive,DESC&paging.sort=id,DESC&paging.size=50", true, true));
    }
    
    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "redirect2List", method = RequestMethod.GET)
    public ModelAndView redirect2List(Map<String, Object> model){
        return new ModelAndView(new RedirectView("/Administration/Products/list?paging.page=1&paging.sort=alive,DESC&paging.sort=id,DESC&paging.size=50", true, true));
    }
    
    /**
     * 
     * @param model
     * @param page
     * @return 
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ModelAndView list(Map<String, Object> model, @PageableDefault(page = 0, size = 50, sort = "alive", direction = Sort.Direction.DESC) Pageable page){
        
        //, new Sort.Order(Sort.Direction.DESC, "id")
        //log.info("sort just alive");
        //page.getSort().and(new Sort(new Sort.Order(Sort.Direction.DESC, "alive")));
        
        Page<VatgiaProduct> pRs = this.vgpSer.findAll(page);
        
        model.put("pRs", pRs);
        
        return new ModelAndView("Administration/products/listProducts");
    }
    
    /**
     * 
     * @param model
     * @param id
     * @param request
     * @return 
     */
    @RequestMapping(value = "input/{id}", method = RequestMethod.GET)
    public ModelAndView inputProduct(Map<String, Object> model, @PathVariable Integer id, HttpServletRequest request){
        
        model.put("categories", this.lxcSer.findAll());
        
        InputProductForm form = new InputProductForm();
        VatgiaProduct vgp = this.vgpSer.findById(id);
        if(vgp != null){
            
            LixiCategory lxc = this.lxcSer.findByVatgiaCategory(this.vgcSer.findOne(vgp.getCategoryId()));
            
            form.setId(vgp.getId());
            form.setCategory(lxc.getId());
            form.setName(vgp.getName());
            form.setImageUrl(vgp.getImageUrl());
            form.setPrice((int)vgp.getOriginalPrice());
            form.setDescription(vgp.getDescription());
            form.setProductSource(vgp.getLinkDetail());
            
        }
        
        model.put("inputProductForm", form);
        
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
            vgp.setId(form.getId());
            vgp.setCategoryId(lxc.getVatgiaId().getId());
            vgp.setCategoryName(lxc.getName());
            log.info("================================");
            log.info(request.getCharacterEncoding());
            log.info(form.getName());
            log.info(LiXiGlobalUtils.toUTF8(form.getName()));
            log.info("================================");
            vgp.setName(form.getName());
            vgp.setOriginalPrice(form.getPrice());
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
        
        return new ModelAndView(new RedirectView("/Administration/Products/input/"+form.getId()+"?success=1", true, true));
    }
}
