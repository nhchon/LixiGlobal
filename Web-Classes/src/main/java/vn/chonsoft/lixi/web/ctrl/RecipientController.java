/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
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
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.RecAdd;
import vn.chonsoft.lixi.model.RecAddOrder;
import vn.chonsoft.lixi.model.RecBank;
import vn.chonsoft.lixi.model.RecBankOrder;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.ShippingCharged;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.form.ChooseRecipientForm;
import vn.chonsoft.lixi.model.form.RecBankForm;
import vn.chonsoft.lixi.model.form.RecipientAddressForm;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.ProvinceService;
import vn.chonsoft.lixi.repositories.service.RecAddOrderService;
import vn.chonsoft.lixi.repositories.service.RecAddService;
import vn.chonsoft.lixi.repositories.service.RecBankOrderService;
import vn.chonsoft.lixi.repositories.service.RecBankService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.ShippingChargedService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.UserSecurityAnnotation;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.LoginedUser;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("recipient")
public class RecipientController {

    private static final Logger log = LogManager.getLogger(RecipientController.class);
    
    private final SimpleDateFormat yyyyMMdd = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    
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
    private RecBankService recBankService;
    
    @Autowired
    private RecAddOrderService raoService;
    
    @Autowired
    private RecBankOrderService rboService;
    
    @Autowired
    private ShippingChargedService shipService;
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "address/thankYou", method = RequestMethod.GET)
    public ModelAndView giftThankYou(Map<String, Object> model, HttpServletRequest request) {
        
        return new ModelAndView("recipient/gifts/giftThankYou");
        
    }
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "refund/thankYou", method = RequestMethod.GET)
    public ModelAndView refundThankYou(Map<String, Object> model, HttpServletRequest request) {
        
        return new ModelAndView("recipient/gifts/refundThankYou");
        
    }
    
    /**
     * 
     * @param model
     * @param recBankId
     * @param oId
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "selectedBankAccount", method = RequestMethod.POST)
    public ModelAndView selectedBankAccount(Map<String, Object> model, @RequestParam Long recBankId, @RequestParam Long oId, HttpServletRequest request) {
        
        /* check order id is valid */
        String oIds = (String)request.getSession().getAttribute("NEW_ORDER_IDS");
        if(oIds == null || !oIds.contains(","+oId.toString()+",")){
            return new ModelAndView(new RedirectView("/user/signOut", true, true));
        }
        
        LixiOrder o = this.lxorderService.findById(oId);
        RecipientInOrder thisRio = getRecipientInOrder(o);
        
        List<RecBankOrder> rbos = this.rboService.findByRecEmailAndBankIdAndOrderId(loginedUser.getEmail(), recBankId, oId);
        
        if(rbos == null || rbos.isEmpty()){
            RecBankOrder rbo = new RecBankOrder();
            rbo.setRecEmail(loginedUser.getEmail());
            rbo.setBankId(recBankId);
            rbo.setOrderId(oId);
            log.info("refund amount: " + thisRio.getRefundAmount());
            rbo.setRefundAmount(thisRio.getRefundAmount());

            this.rboService.save(rbo);
        }
        
        /* update receive method */
        if(o.getGifts() != null){
            for(LixiOrderGift g : o.getGifts()){
                if(loginedUser.getEmail().equals(g.getRecipientEmail())){
                    g.setBkReceiveMethod(LiXiGlobalConstants.BAOKIM_MONEY_METHOD);
                    g.setBkUpdated(yyyyMMdd.format(Calendar.getInstance().getTime()));

                    this.lxogiftService.save(g);
                }
            }
        }
        
        return new ModelAndView(new RedirectView("/recipient/refund/thankYou", true, true));
    }
    
    /**
     * 
     * @param model
     * @param oId
     * @param id
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "deleteBankAccount", method = RequestMethod.POST)
    public ModelAndView deleteBankAccount(Map<String, Object> model, @RequestParam Long oId, @RequestParam Long id, HttpServletRequest request) {
        
        List<RecBankOrder> rbo = this.rboService.findByBankId(id);
        // check if it in use
        if(rbo==null || rbo.isEmpty()){
            
            RecBank rb = this.recBankService.findById(loginedUser.getEmail(), id);
            if(rb != null){

                this.recBankService.delete(id);
            }
        }
        
        return new ModelAndView(new RedirectView("/recipient/refund/" + oId, true, true)); 
    }
    
    /**
     * 
     * @param oId
     * @return 
     */
    private RecipientInOrder getRecipientInOrder(Long oId){
        
        return getRecipientInOrder(this.lxorderService.findById(oId));
    }
    
    /**
     * 
     * @param o
     * @return 
     */
    private RecipientInOrder getRecipientInOrder(LixiOrder o){
        // get recipient in order
        RecipientInOrder recInOrder = null;
        List<RecipientInOrder> recInOrders = LiXiUtils.genMapRecGifts(o);
        if(recInOrders != null){
            for(RecipientInOrder rio : recInOrders){
                if(rio.getRecipient().getEmail().equals(loginedUser.getEmail())){
                    recInOrder = rio;
                    break;
                }
            }
            List<ShippingCharged> charged = this.shipService.findAll();
            if(recInOrder != null) recInOrder.setCharged(charged);
        }
        
        return recInOrder;
    }
    
    /**
     * 
     * @param model
     * @param oId
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "refund/{oId}", method = RequestMethod.GET)
    public ModelAndView refund(Map<String, Object> model, @PathVariable Long oId, HttpServletRequest request) {
        
        RecipientInOrder thisRio = getRecipientInOrder(oId);
        
        model.put("provinces", this.provinceService.findAll());
        model.put("rio", thisRio);
        model.put("rbs", this.recBankService.findByEmail(loginedUser.getEmail()));
        model.put("totalRefund", thisRio.getRefundAmount());
        
        RecBankForm form = new RecBankForm();
        form.setOId(oId);
        model.put("recBankForm", form);
        
        return new ModelAndView("recipient/gifts/inputBank");
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
    @RequestMapping(value = "refund", method = RequestMethod.POST)
    public ModelAndView refund(Map<String, Object> model,
            @Valid RecBankForm form, Errors errors, HttpServletRequest request) {
        
        model.put("provinces", this.provinceService.findAll());
        RecipientInOrder thisRio = getRecipientInOrder(form.getOId());
        model.put("rio", thisRio);
        model.put("rbs", this.recBankService.findByEmail(loginedUser.getEmail()));
        
        if (errors.hasErrors()) {
            return new ModelAndView("recipient/gifts/inputBank");
        }
        
        try {
            /* check order id is valid */
            String oIds = (String)request.getSession().getAttribute("NEW_ORDER_IDS");
            if(oIds == null || !oIds.contains("," + form.getOId().toString()+",")){
                return new ModelAndView(new RedirectView("/user/signOut", true, true));
            }
            
            RecBank recBank = new RecBank();
            recBank.setRecEmail(loginedUser.getEmail());
            recBank.setTenNguoiHuong(form.getTenNguoiHuong());
            recBank.setSoTaiKhoan(form.getSoTaiKhoan());
            recBank.setBankName(form.getBankName());
            recBank.setChiNhanh(form.getChiNhanh());
            log.info(form.getChiNhanh());
            recBank.setProvince(this.provinceService.findById(form.getRecProvince()));
            recBank.setRecipient(this.reciService.findByEmail(loginedUser.getEmail()));
            
            recBank = this.recBankService.save(recBank);
            
            /* save rec-bank-order */
            RecBankOrder rbo = new RecBankOrder();
            rbo.setRecEmail(loginedUser.getEmail());
            rbo.setBankId(recBank.getId());
            rbo.setOrderId(form.getOId());
            rbo.setRefundAmount(thisRio.getRefundAmount());
        
            this.rboService.save(rbo);
            
            /* update receive method */
            LixiOrder o = this.lxorderService.findById(form.getOId());
            if(o.getGifts() != null){
                for(LixiOrderGift g : o.getGifts()){
                    if(loginedUser.getEmail().equals(g.getRecipientEmail())){
                        g.setBkReceiveMethod(LiXiGlobalConstants.BAOKIM_MONEY_METHOD);
                        g.setBkUpdated(yyyyMMdd.format(Calendar.getInstance().getTime()));

                        this.lxogiftService.save(g);
                    }
                }
            }
        } catch (ConstraintViolationException e) {
            
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("recipient/gifts/inputBank");
            
        }
        
        return new ModelAndView(new RedirectView("/recipient/refund/thankYou", true, true));
    }
    
    /**
     * 
     * @param model
     * @param oId
     * @param id
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "deleteAddress", method = RequestMethod.POST)
    public ModelAndView deleteAddress(Map<String, Object> model, @RequestParam Long oId, @RequestParam Long id, HttpServletRequest request) {
        
        // check if id not in use
        List<RecAddOrder> raos = this.raoService.findByAddId(id);
        log.info("raos is empty: " + (raos.isEmpty()));
        
        if(raos==null || raos.isEmpty()){
            
            RecAdd ra = this.recAddService.findById(loginedUser.getEmail(), id);
            
            log.info("ra is empty: " + (ra == null));
            if(ra != null){
                log.info("delete address: ");
                this.recAddService.delete(id);
            }
        }
        
        return new ModelAndView(new RedirectView("/recipient/address/" + oId, true, true)); 
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
        
        /* check order id is valid */
        String oIds = (String)request.getSession().getAttribute("NEW_ORDER_IDS");
        if(oIds == null || !oIds.contains(","+oId.toString()+",")){
            return new ModelAndView(new RedirectView("/user/signOut", true, true));
        }
        
        List<RecAddOrder> raos = this.raoService.findByRecEmailAndAddIdAndOrderId(loginedUser.getEmail(), recAddId, oId);
        if(raos == null || raos.isEmpty()){
            RecAddOrder rao = new RecAddOrder();
            rao.setRecEmail(loginedUser.getEmail());
            rao.setAddId(recAddId);
            rao.setOrderId(oId);

            this.raoService.save(rao);
        }
        
        /* update receive method */
        LixiOrder o = this.lxorderService.findById(oId);
        if(o.getGifts() != null){
            for(LixiOrderGift g : o.getGifts()){
                if(loginedUser.getEmail().equals(g.getRecipientEmail())){
                    g.setBkReceiveMethod(LiXiGlobalConstants.BAOKIM_GIFT_METHOD);
                    g.setBkUpdated(yyyyMMdd.format(Calendar.getInstance().getTime()));

                    this.lxogiftService.save(g);
                }
            }
        }
        
        return new ModelAndView(new RedirectView("/recipient/address/thankYou", true, true));
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
            /* check order id is valid */
            String oIds = (String)request.getSession().getAttribute("NEW_ORDER_IDS");
            if(oIds == null || !oIds.contains("," + form.getOId().toString()+",")){
                return new ModelAndView(new RedirectView("/user/signOut", true, true));
            }
            
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
            
            /* update receive method */
            LixiOrder o = this.lxorderService.findById(form.getOId());
            if(o.getGifts() != null){
                for(LixiOrderGift g : o.getGifts()){
                    if(loginedUser.getEmail().equals(g.getRecipientEmail())){
                        g.setBkReceiveMethod(LiXiGlobalConstants.BAOKIM_GIFT_METHOD);
                        g.setBkUpdated(yyyyMMdd.format(Calendar.getInstance().getTime()));

                        this.lxogiftService.save(g);
                    }
                }
            }
        } catch (ConstraintViolationException e) {
            
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("recipient/gifts/inputAddress");
            
        }
        
        return new ModelAndView(new RedirectView("/recipient/address/thankYou", true, true));
    }
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "gifts/status", method = RequestMethod.GET)
    public ModelAndView giftStatus(Map<String, Object> model, HttpServletRequest request) {
        
        // new gifts, recipient did not do anything
        List<String> statuses = Arrays.asList(EnumLixiOrderStatus.PROCESSED.getValue(), EnumLixiOrderStatus.PURCHASED.getValue(), EnumLixiOrderStatus.DELIVERED.getValue(),
                EnumLixiOrderStatus.UNDELIVERABLE.getValue(), EnumLixiOrderStatus.REFUNDED.getValue(),
                EnumLixiOrderStatus.CANCELED.getValue(), EnumLixiOrderStatus.COMPLETED.getValue());
        List<LixiOrderGift> proGifts = this.lxogiftService.findByRecipientEmailAndBkStatusIn(loginedUser.getEmail(), statuses);
        
        /**
         * get order id list
         * 
         * https://coderanch.com/t/623127/java/java/array-specific-attribute-values-list
         */
        List<Long> proIds = proGifts.stream().map(g -> g.getOrder().getId()).collect(Collectors.toList());
        LiXiGlobalUtils.removeDupEle(proIds);
        
        Map<LixiOrder, List<RecipientInOrder>> mOs = new LinkedHashMap<>();
        List<ShippingCharged> charged = this.shipService.findAll();
        
        List<LixiOrder> orders = lxorderService.findAll(proIds);
        if (orders != null) {
            orders.forEach(o -> {

                List<RecipientInOrder> recInOrder = LiXiUtils.genMapRecGifts(o);
                recInOrder.forEach(r -> {
                    r.setCharged(charged);
                    // get delivery address
                    RecAdd ra = null;
                    List<RecAddOrder> raos = this.raoService.findByOrderIdAndRecEmail(o.getId(), r.getRecipient().getEmail());
                    if (raos != null && !raos.isEmpty()) {
                        ra = this.recAddService.findById(raos.get(0).getAddId());
                    }
                    // set delivery address
                    r.setRecAdd(ra);
                    
                    // get bank account
                    RecBank rb = null;
                    List<RecBankOrder> rbos = this.rboService.findByOrderIdAndRecEmail(o.getId(), r.getRecipient().getEmail());
                    if (rbos != null && !rbos.isEmpty()) {
                        rb = this.recBankService.findById(rbos.get(0).getBankId());
                    }
                    // set bank account
                    r.setRecBank(rb);
                });

                mOs.put(o, recInOrder);
            });
        }

        model.put("mOs", mOs);
        
        return new ModelAndView("recipient/gifts/giftStatus");
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
        List<String> statuses = Arrays.asList(EnumLixiOrderStatus.UN_PROCESSED.getValue(), EnumLixiOrderStatus.PROCESSED.getValue());
        List<LixiOrderGift> proGifts = this.lxogiftService.findByRecipientEmailAndBkReceiveMethodAndBkStatusIn(loginedUser.getEmail(), null, statuses);
        
        /**
         * get order id list
         * 
         * https://coderanch.com/t/623127/java/java/array-specific-attribute-values-list
         */
        List<Long> proIds = proGifts.stream().map(g -> g.getOrder().getId()).collect(Collectors.toList());
        LiXiGlobalUtils.removeDupEle(proIds);
        
        List<LixiOrder> proOrders = lxorderService.findAll(proIds);

        String oIds = StringUtils.join(proIds, ',');
        if(oIds != null){
            if(!oIds.startsWith(",")){
                oIds = ","+oIds;
            }
            if(!oIds.endsWith(",")){
                oIds = oIds + ",";
            }
        }
        
        log.info("NEW_ORDER_IDS: " + oIds);
        
        request.getSession().setAttribute("NEW_ORDER_IDS", oIds);
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
