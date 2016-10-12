/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.RecAdd;
import vn.chonsoft.lixi.model.RecAddOrder;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.form.ChooseRecipientForm;
import vn.chonsoft.lixi.model.form.RecipientAddressForm;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.ProvinceService;
import vn.chonsoft.lixi.repositories.service.RecAddOrderService;
import vn.chonsoft.lixi.repositories.service.RecAddService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.UserSecurityAnnotation;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.LoginedUser;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("recipient")
public class RecipientController {

    private static final Logger log = LogManager.getLogger(RecipientController.class);
    
    /* session bean - Login user */
    @Autowired
    private LoginedUser loginedUser;

    @Autowired
    private RecipientService reciService;

    @Autowired
    private UserService userService;

    @Autowired
    private ThreadPoolTaskScheduler taskScheduler;

    @Autowired
    private VelocityEngine velocityEngine;

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private LixiOrderService lxorderService;

    @Autowired
    private LixiOrderGiftService lxogiftService;

    @Autowired
    private ProvinceService provinceService;
    
    @Autowired
    private RecAddService recAddService;
    
    @Autowired
    private RecAddOrderService raoService;
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "thankYou", method = RequestMethod.GET)
    public ModelAndView address(Map<String, Object> model, HttpServletRequest request) {
        
        return new ModelAndView("recipient/gifts/thankYou");
        
    }
    
    /**
     * 
     * @param model
     * @param recAddId
     * @param oId
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "selectedAddress", method = RequestMethod.POST)
    public ModelAndView selecAddress(Map<String, Object> model, @RequestParam Long recAddId, @RequestParam Long oId, HttpServletRequest request) {
        
        RecAddOrder rao = new RecAddOrder();
        rao.setRecEmail(loginedUser.getEmail());
        rao.setAddId(recAddId);
        rao.setOrderId(oId);
        
        this.raoService.save(rao);
        
        return new ModelAndView(new RedirectView("/recipient/thankYou", true, true));
    }
    
    /**
     * 
     * @param model
     * @param oId
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "address/{oId}", method = RequestMethod.GET)
    public ModelAndView address(Map<String, Object> model, @PathVariable Long oId, HttpServletRequest request) {
        
        model.put("recAdds", this.recAddService.findByEmail(loginedUser.getEmail()));
        model.put("order", this.lxorderService.findById(oId));
        model.put("provinces", this.provinceService.findAll());
        
        RecipientAddressForm form = new RecipientAddressForm();
        form.setOId(oId);
        model.put("recipientAddressForm", form);
        
        return new ModelAndView("recipient/gifts/inputAddress");
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "address", method = RequestMethod.POST)
    public ModelAndView address(Map<String, Object> model,
            @Valid RecipientAddressForm form, Errors errors, HttpServletRequest request) {
        
        model.put("recAdds", this.recAddService.findByEmail(loginedUser.getEmail()));
        model.put("order", this.lxorderService.findById(form.getOId()));
        model.put("provinces", this.provinceService.findAll());
        
        if (errors.hasErrors()) {
            return new ModelAndView("recipient/gifts/inputAddress");
        }
        
        try {
            
            RecAdd recAdd = new RecAdd();
            recAdd.setName(form.getRecName());
            recAdd.setEmail(loginedUser.getEmail());
            recAdd.setAddress(form.getRecAddress());
            recAdd.setProvince(this.provinceService.findById(form.getRecProvince()));
            recAdd.setDistrict(form.getRecDist());
            recAdd.setWard(form.getRecWard());
            recAdd.setPhone(form.getRecPhone());
            recAdd.setRecipient(this.reciService.findByEmail(loginedUser.getEmail()));
            
            recAdd = this.recAddService.save(recAdd);
            
            /* save rec-add-order */
            RecAddOrder rao = new RecAddOrder();
            rao.setRecEmail(loginedUser.getEmail());
            rao.setAddId(recAdd.getId());
            rao.setOrderId(form.getOId());
        
            this.raoService.save(rao);
            
        } catch (ConstraintViolationException e) {
            
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("recipient/gifts/inputAddress");
            
        }
        
        return new ModelAndView(new RedirectView("/recipient/thankYou", true, true));
    }
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "gifts", method = RequestMethod.GET)
    public ModelAndView gifts(Map<String, Object> model, HttpServletRequest request) {
        
        // new gifts, recipient did not do anything
        List<LixiOrderGift> proGifts = this.lxogiftService.findByRecipientEmailAndBkStatusAndBkReceiveMethod(loginedUser.getEmail(), EnumLixiOrderStatus.PROCESSED.getValue(), null);
        
        /**
         * get order id list
         * 
         * https://coderanch.com/t/623127/java/java/array-specific-attribute-values-list
         */
        List<Long> proIds = proGifts.stream().map(g -> g.getOrder().getId()).collect(Collectors.toList());
        List<LixiOrder> proOrders = lxorderService.findAll(proIds);

        model.put("NEW_ORDERS", proOrders);
        
        return new ModelAndView("recipient/gifts/newGifts");
    }
    
    @UserSecurityAnnotation
    @RequestMapping(value = "get/{email:.+}", method = RequestMethod.GET)
    public ModelAndView getRecipient(Map<String, Object> model, @PathVariable String email) {

        Recipient rec = this.reciService.findByEmail(email);
        
        log.info("rec email: " + email);
        log.info("rec is null: " + (rec==null));
        
        model.put("error", 0);
        model.put("rec", rec);

        return new ModelAndView("recipient/recJson");
    }
    
    /**
     *
     * @param model
     * @param id
     * @return
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "deactivated/{id}", method = RequestMethod.GET)
    public ModelAndView deactivated(Map<String, Object> model, @PathVariable Long id) {

        Recipient rec = this.reciService.findById(id);
        if (rec != null) {
            rec.setActivated(false);
            this.reciService.save(rec);
        }

        model.put("error", 0);
        model.put("recId", id);

        return new ModelAndView("recipient/message");
    }

    /**
     *
     * @param model
     * @param id
     * @param request
     * @return
     */
    @UserSecurityAnnotation
    @RequestMapping(value = {"edit/{id}", "ajax/edit/{id}"}, method = RequestMethod.GET)
    public ModelAndView editRecipient(Map<String, Object> model, @PathVariable Long id, HttpServletRequest request) {

        ChooseRecipientForm form = new ChooseRecipientForm();
        if (id > 0) {
            /* get recipient */
            Recipient rec = this.reciService.findById(id);
            if (rec != null) {
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
        } else {
            form.setNote("Happy Birthday");
            form.setAction("create");
        }

        model.put("chooseRecipientForm", form);

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
    @UserSecurityAnnotation
    @RequestMapping(value = {"editRecipient", "ajax/editRecipient"}, method = RequestMethod.POST)
    public ModelAndView editRecipient(Map<String, Object> model,
            @Valid ChooseRecipientForm form, Errors errors, HttpServletRequest request) {

        User u = this.userService.findByEmail(loginedUser.getEmail());

        // for error
        model.put("error", 1);
        model.put("name", "");
        model.put("action", form.getAction());

        if (errors.hasErrors()) {

            return new ModelAndView("recipient/message");
        }

        try {
            String f = LiXiGlobalUtils.html2text(form.getFirstName());
            String m = LiXiGlobalUtils.html2text(form.getMiddleName());
            String l = LiXiGlobalUtils.html2text(form.getLastName());
            if (StringUtils.isBlank(f) || StringUtils.isBlank(l)) {
                
            } else {
                // save or update the recipient
                Recipient rec = this.reciService.findByEmail(form.getEmail());
                if(rec == null){
                    rec = new Recipient();
                    rec.setId(form.getRecId());
                }
                /* create new or update information if rec exist */
                rec.setSender(u);
                rec.setFirstName(f);
                rec.setMiddleName(m);
                rec.setLastName(l);
                rec.setEmail(form.getEmail());
                rec.setDialCode(form.getDialCode());
                rec.setPhone(form.getPhone());
                rec.setActivated(true);
                rec.setNote(LiXiGlobalUtils.html2text(form.getNote()));// LiXiUtils.fixEncode
                rec.setModifiedDate(Calendar.getInstance().getTime());

                rec = this.reciService.save(rec);

                // store selected recipient into session
                String recName = f + (StringUtils.isEmpty(m)?" ": " "+m+" ") + l;
                request.getSession().setAttribute(LiXiConstants.SELECTED_RECIPIENT_ID, rec.getId());
                request.getSession().setAttribute(LiXiConstants.SELECTED_RECIPIENT_NAME, recName);

                //email
                emailNewRecipient(u, rec);

                // return
                model.put("error", 0);
                model.put("recId", rec.getId());
                model.put("name", recName);
            }
            
            return new ModelAndView("recipient/message");

        } catch (ConstraintViolationException e) {

            return new ModelAndView("recipient/message");

        }

    }

    /**
     *
     * @param u
     * @param r
     */
    private void emailNewRecipient(User u, Recipient r) {
        // send Email
        MimeMessagePreparator preparator = new MimeMessagePreparator() {

            @SuppressWarnings({"rawtypes", "unchecked"})
            @Override
            public void prepare(MimeMessage mimeMessage) throws Exception {

                MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                message.setTo(u.getEmail());
                //message.setCc(LiXiGlobalConstants.CHONNH_GMAIL);
                message.setFrom("support@lixi.global");
                message.setSubject("LiXi.Global - Receiver Info Alert");
                message.setSentDate(Calendar.getInstance().getTime());

                Map model = new HashMap();
                model.put("user", u);
                model.put("r", r);

                String text = VelocityEngineUtils.mergeTemplateIntoString(
                        velocityEngine, "emails/new-receiver.vm", "UTF-8", model);
                message.setText(text, true);
            }
        };

        // send oldEmail
        taskScheduler.execute(() -> mailSender.send(preparator));
    }
}
