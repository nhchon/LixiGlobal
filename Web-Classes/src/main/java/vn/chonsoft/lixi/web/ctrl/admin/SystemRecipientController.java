/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.form.ChooseRecipientForm;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.ScalarFunctionService;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping(value = "/Administration/SystemRecipient")
public class SystemRecipientController {
    
    @Autowired
    private RecipientService recService;
    
    @Autowired
    private ScalarFunctionService sfService;
    
    /**
     *
     * @param model
     * @param id
     * @param request
     * @return
     */
    @RequestMapping(value = "view/{id}", method = RequestMethod.GET)
    public ModelAndView viewRecipient(Map<String, Object> model, @PathVariable Long id, HttpServletRequest request) {

        /* get recipient */
        Recipient rec = this.recService.findById(id);

        model.put("rec", rec);

        return new ModelAndView("recipient/viewRecipientModal");
    }
    
    
    /**
     * 
     * @param model
     * @param id
     * @param request
     * @return 
     */
    @RequestMapping(value = "edit/{id}", method = RequestMethod.GET)
    public ModelAndView editRecipient(Map<String, Object> model, @PathVariable Long id, HttpServletRequest request) {

        ChooseRecipientForm form = new ChooseRecipientForm();
        if (id > 0) {
            /* get recipient */
            Recipient rec = this.recService.findById(id);
            if(rec != null){
                form.setRecId(rec.getId());
                form.setFirstName(rec.getFirstName());
                form.setMiddleName(rec.getMiddleName());
                form.setLastName(rec.getLastName());
                form.setEmail(rec.getEmail());
                form.setConfEmail(rec.getEmail());
                form.setDialCode(rec.getDialCode());
                form.setPhone(rec.getPhone());
                form.setNote(rec.getNote());
                form.setAction("edit");
            }
        }
        else{
            form.setNote("Happy Birthday");
            form.setAction("create");
        }

        model.put("chooseRecipientForm", form);
        
        model.put("adminEditRecipient", "/Administration/SystemRecipient/edit");
        
        return new ModelAndView("recipient/editRecipientModal");
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @RequestMapping(value = "edit", method = RequestMethod.POST)
    public ModelAndView editRecipient(Map<String, Object> model,
            @Valid ChooseRecipientForm form, Errors errors, HttpServletRequest request) {

        // for error
        model.put("error", 1);
        model.put("action", form.getAction());
        
        if (errors.hasErrors()) {

            return new ModelAndView("recipient/message");
        }

        try {
            // save or update the recipient
            Recipient rec = this.recService.findById(form.getRecId());
            rec.setFirstName(form.getFirstName());
            rec.setMiddleName(form.getMiddleName());
            rec.setLastName(form.getLastName());
            rec.setEmail(form.getEmail());
            rec.setDialCode(form.getDialCode());
            rec.setPhone(form.getPhone());
            rec.setNote((form.getNote()));// LiXiUtils.fixEncode
            rec.setModifiedDate(Calendar.getInstance().getTime());

            rec = this.recService.save(rec);

            // return
            model.put("error", 0);
            model.put("recId", rec.getId());
            
            return new ModelAndView("recipient/message");

        } catch (ConstraintViolationException e) {

            return new ModelAndView("recipient/message");

        }

    }
    
    /**
     * 
     * @return 
     */
    @RequestMapping(value = "report", method = RequestMethod.GET)
    public ModelAndView report(){
        
        return new ModelAndView(new RedirectView("/Administration/SystemRecipient/report/Processed", true, true));
    }
    
    /**
     * 
     * @param oStatus
     * @param model
     * @param page
     * @return 
     */
    @RequestMapping(value = "report/{oStatus}", method = RequestMethod.GET)
    public ModelAndView report(Map<String, Object> model, @PathVariable String oStatus, @PageableDefault(value = 50, sort = "id", direction = Sort.Direction.DESC) Pageable page){
        
        Page<Recipient> ps = this.recService.findAll(page);
        
        List<Recipient> rS = new ArrayList<>();
        
        if(ps != null && !ps.getContent().isEmpty()){
            
            ps.getContent().forEach(r -> {
                if(EnumLixiOrderStatus.PROCESSED.getValue().equals(oStatus) || 
                   EnumLixiOrderStatus.COMPLETED.getValue().equals(oStatus) || 
                   EnumLixiOrderStatus.CANCELED.getValue().equals(oStatus)){
                    
                    r.setSumGift(sfService.sumGiftOfRecipientByOrderStatus(oStatus, r.getId()));
                    r.setSumTopUp(sfService.sumTopUpOfRecipientByOrderStatus(oStatus, r.getId()));
                }
                else{
                    r.setSumGift(sfService.sumGiftOfRecipient(oStatus, r.getId()));
                    r.setSumTopUp(sfService.sumTopUpOfRecipient(oStatus, r.getId()));
                }
            });
            
            rS = new ArrayList<>(ps.getContent());
            
            rS.sort((Recipient r1, Recipient r2)->{return r2.getSumAll().compareTo(r1.getSumAll());});
        }
        
        model.put("rS", rS);
        model.put("pRs", ps);
        model.put("VCB", LiXiGlobalUtils.getVCBExchangeRates());
        
        return new ModelAndView("Administration/reports/receivers");
    }
}
