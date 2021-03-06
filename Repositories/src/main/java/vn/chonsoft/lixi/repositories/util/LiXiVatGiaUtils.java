/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import javax.mail.internet.MimeMessage;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.apache.http.HttpHost;
import org.apache.http.impl.client.HttpClients;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.stereotype.Service;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import vn.chonsoft.lixi.EnumLixiOrderSetting;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.VatgiaCategory;
import vn.chonsoft.lixi.model.VatgiaProduct;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.LixiConfig;
import vn.chonsoft.lixi.model.TopUpMobilePhone;
import vn.chonsoft.lixi.model.pojo.ListVatGiaCategory;
import vn.chonsoft.lixi.model.pojo.ListVatGiaProduct;
import vn.chonsoft.lixi.model.pojo.LixiCheckStatusResult;
import vn.chonsoft.lixi.model.pojo.LixiSendShippingFeeResult;
import vn.chonsoft.lixi.model.pojo.LixiSubmitOrderResult;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.model.pojo.VatGiaCategoryPj;
import vn.chonsoft.lixi.model.pojo.VatGiaProductPj;
import vn.chonsoft.lixi.repositories.service.LixiConfigService;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;

/**
 *
 * (Singleton pattern)
 *
 * @author chonnh
 */
@Service
public class LiXiVatGiaUtils {

    public static final String SUBJECT = "Bao Kim System Error";
    
    private static final Logger log = LogManager.getLogger(LiXiVatGiaUtils.class);

    private Properties baokimProp = null;
    
    @Autowired
    private LixiOrderService orderService;

    @Autowired
    private LixiOrderGiftService orderGiftService;
    
    @Autowired
    private LixiConfigService configService;
    
    @Autowired
    private ThreadPoolTaskScheduler taskScheduler;
    
    @Autowired
    private VelocityEngine velocityEngine;
    
    @Autowired
    private JavaMailSender mailSender;
    
    /**
     *
     */
    public LiXiVatGiaUtils() {

        try {

            /* Load baokim properties */
            Resource resource = new ClassPathResource("/baokim.properties");
            baokimProp = PropertiesLoaderUtils.loadProperties(resource);

        } catch (Exception e) {

            log.info("Load baokim.properties is failed", e);

        }

    }

    /* business methods */
    /**
     *
     * @param vgcpojo
     * @return
     */
    public VatgiaCategory convertFromPojo2Model(VatGiaCategoryPj vgcpojo) {

        return new VatgiaCategory(vgcpojo.getId(), vgcpojo.getTitle(), 0, 9999);

    }

    /**
     *
     * @param vgcpojos
     * @return
     */
    public List<VatgiaCategory> convertFromPojo2Model(ListVatGiaCategory vgcpojos) {

        List<VatgiaCategory> vgcs = new ArrayList<>();

        if (vgcpojos == null) {
            return vgcs;
        }

        for (VatGiaCategoryPj vgcpojo : vgcpojos.getData()) {

            VatgiaCategory vgc = new VatgiaCategory(vgcpojo.getId(), vgcpojo.getTitle(), 0, 9999);

            vgcs.add(vgc);

        }

        return vgcs;

    }

    /**
     *
     * @param pj
     * @return
     */
    public VatgiaProduct convertVatGiaProduct2Model(VatGiaProductPj pj) {

        if (pj == null) {
            return null;
        }
        //
        VatgiaProduct p = new VatgiaProduct();
        p.setId(pj.getId());
        p.setCategoryId(pj.getCategory_id());
        p.setCategoryName(pj.getCategory_name());
        p.setName(pj.getName());
        p.setDescription(pj.getDescription());
        p.setPrice(pj.getPrice());
        p.setImageUrl(pj.getImage_url());
        p.setImageFullSize(pj.getImage_full_size());
        p.setLinkDetail(pj.getLink_detail());
        p.setAlive(1);
        p.setModifiedDate(Calendar.getInstance().getTime());

        return p;
    }

    /**
     *
     * @param pjs
     * @return
     */
    public List<VatgiaProduct> convertVatGiaProduct2Model(ListVatGiaProduct pjs) {

        if (pjs == null || pjs.getData() == null) {
            return null;
        }
        //
        List<VatgiaProduct> ps = new ArrayList<>();
        for (VatGiaProductPj p : pjs.getData()) {
            
            ps.add(convertVatGiaProduct2Model(p));

        }
        //
        return ps;
    }

    /**
     * 
     */
    private String[] checkAndAssignDefaultEmail(){
        LixiConfig c = configService.findByName(LiXiGlobalConstants.LIXI_ADMINISTRATOR_EMAIL);
        if(c == null || StringUtils.isBlank(c.getValue())){
            return new String[] {LiXiGlobalConstants.YHANNART_GMAIL};
        }
        else{
            return c.getValue().split(";");
        }
    }
    
    private void emailBaoKimSystemError(String subject, String error){
        
        String[] administratorEmails = checkAndAssignDefaultEmail();
        
        // send Email
        MimeMessagePreparator preparator = new MimeMessagePreparator() {

            @SuppressWarnings({ "rawtypes", "unchecked" })
            @Override
            public void prepare(MimeMessage mimeMessage) throws Exception {

                MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                message.setTo(administratorEmails);
                message.setCc(LiXiGlobalConstants.YHANNART_GMAIL);
                message.addCc(LiXiGlobalConstants.CHONNH_GMAIL);
                message.setFrom("support@lixi.global");
                message.setSubject("LiXi.Global - " + subject); // Bao Kim System Error
                message.setSentDate(Calendar.getInstance().getTime());

                Map model = new HashMap();
                model.put("name", "Yuric");
                model.put("err", error);

                String text = VelocityEngineUtils.mergeTemplateIntoString(
                   velocityEngine, "emails/baokim-error.vm", "UTF-8", model);
                message.setText(text, true);
              }
        };        

        // send oldEmail
        taskScheduler.execute(() -> mailSender.send(preparator));
        
    }
    /**
     *
     * @return
     */
    public ListVatGiaCategory getVatGiaCategory() {

        // check properties is null
        if (baokimProp == null) {
            return null;
        }
        //
        try {

            final AuthHttpComponentsClientHttpRequestFactory requestFactory
                    = new AuthHttpComponentsClientHttpRequestFactory(
                            HttpClients.createDefault(), HttpHost.create(baokimProp.getProperty("baokim.host")), baokimProp.getProperty("baokim.username"), baokimProp.getProperty("baokim.password"));
            //
            final RestTemplate restTemplate = new RestTemplate(requestFactory);
            //
            return restTemplate.getForObject(baokimProp.getProperty("baokim.list_category_page"), ListVatGiaCategory.class);

        } catch (Exception e) {

            log.info(e.getMessage(), e);
            
            emailBaoKimSystemError(SUBJECT, ExceptionUtils.getStackTrace(e).replaceAll("(\r\n|\n)", "<br />"));
        }

        return null;
    }

    /**
     *
     * get product list returned by categorory id and price
     *
     * @param categoryId
     * @param price
     * @return
     */
    public ListVatGiaProduct getVatGiaProducts(int categoryId, double price) {
        // check properties is null
        if (baokimProp == null) {
            return null;
        }
        //
        try {

            final AuthHttpComponentsClientHttpRequestFactory requestFactory
                    = new AuthHttpComponentsClientHttpRequestFactory(
                            HttpClients.createDefault(), HttpHost.create(baokimProp.getProperty("baokim.host")), baokimProp.getProperty("baokim.username"), baokimProp.getProperty("baokim.password"));

            final RestTemplate restTemplate = new RestTemplate(requestFactory);

            String genUrl = baokimProp.getProperty("baokim.list_product_page") + "?category_id=" + categoryId + "&price=" + price;

            log.info(genUrl);

            return restTemplate.getForObject(genUrl, ListVatGiaProduct.class);

        } catch (Exception e) {

            log.info(e.getMessage(), e);
            emailBaoKimSystemError(SUBJECT, ExceptionUtils.getStackTrace(e).replaceAll("(\r\n|\n)", "<br />"));

        }

        return null;
    }

    /**
     *
     * @param str
     * @return
     */
    private String emptyIfNull(String str) {

        if (str == null) {
            return "";
        } else {
            return str;
        }

    }

    /**
     *
     * @param setting
     * @return
     */
    private int convertOrderSetting(int setting) {

        // allow refund
        if (setting == 1) {
            return setting;
        }

        // 2 is gift only on baokim service
        if (setting == 0) {
            return 2;
        }

        return setting;
    }
    
    /**
     * 
     * @param recs 
     */
    public void sendShippingFee(List<RecipientInOrder> recs){
        
        // check properties is null
        if (baokimProp == null) {
            return;
        }
        if (recs == null) {
            return;
        }
        
        try {

            final AuthHttpComponentsClientHttpRequestFactory requestFactory
                    = new AuthHttpComponentsClientHttpRequestFactory(
                            HttpClients.createDefault(), HttpHost.create(baokimProp.getProperty("baokim.host")), baokimProp.getProperty("baokim.username"), baokimProp.getProperty("baokim.password"));

            final RestTemplate restTemplate = new RestTemplate(requestFactory);

            String baoKimShippingFeeUrl = baokimProp.getProperty("baokim.send_shipping_fee");
            for (RecipientInOrder r : recs) {

                try {
                    
                    if(r.getGifts() != null && !r.getGifts().isEmpty()){
                        /**
                         *
                         * Setting up data to be sent to REST service
                         *
                         */
                        MultiValueMap<String, String> vars = new LinkedMultiValueMap<>();
                        vars.add("lixi_order_id", r.getOrderId().toString());
                        vars.add("receiver_email", r.getRecipient().getEmail());
                        vars.add("shipping_fee", r.getShippingChargeAmountVnd()+"");
                        //
                        log.info("///////////////////////////////////////////////////");
                        log.info("lixi_order_id: " + r.getOrderId().toString());
                        log.info("receiver_email:" + r.getRecipient().getEmail());
                        log.info("shipping_fee:" + r.getShippingChargeAmountVnd()+"");
                        log.info("///////////////////////////////////////////////////");

                        LixiSendShippingFeeResult result = restTemplate.postForObject(baoKimShippingFeeUrl, vars, LixiSendShippingFeeResult.class);

                        log.info("////////////////////////////////////////////////////");
                        log.info("//// SEND SHIPPING FEE RESULT ");
                        log.info("error_code:" + result.getData().getError_code());
                        log.info("bk message:" + result.getData().getMessage());
                        log.info("lixi order id:" + result.getData().getLixi_order_id());
                        log.info("///////////////////////////////////////////////////");
                    }
                } catch (Exception e) {
                    // log error
                    log.info(e.getMessage(), e);
                    emailBaoKimSystemError("SUBMIT SHIPPING FEE FAILED", ExceptionUtils.getStackTrace(e).replaceAll("(\r\n|\n)", "<br />"));
                }
            }
        } catch (Exception e) {

            log.info(e.getMessage(), e);
            emailBaoKimSystemError("SUBMIT SHIPPING FEE FAILED", ExceptionUtils.getStackTrace(e).replaceAll("(\r\n|\n)", "<br />"));
        }
    }
    
    /**
     *
     * @param order
     */
    public void submitOrdersToBaoKim(LixiOrder order) {

        // check properties is null
        if (baokimProp == null) {
            return;
        }
        if (order == null) {
            return;
        }
        if (order.getGifts() == null || order.getGifts().isEmpty()) {
            return;
        }
        
        //
        try {

            final AuthHttpComponentsClientHttpRequestFactory requestFactory
                    = new AuthHttpComponentsClientHttpRequestFactory(
                            HttpClients.createDefault(), HttpHost.create(baokimProp.getProperty("baokim.host")), baokimProp.getProperty("baokim.username"), baokimProp.getProperty("baokim.password"));

            final RestTemplate restTemplate = new RestTemplate(requestFactory);

            String submitUrl = baokimProp.getProperty("baokim.submit_order");
            String senderName = StringUtils.join(new String[]{order.getSender().getFirstName(), order.getSender().getMiddleName(), order.getSender().getLastName()}, " ");
            String senderEmail = order.getSender().getEmail();
            String senderPhone = emptyIfNull(order.getSender().getPhone());
            boolean updateOrderStatus = true;
            String methodReceive = convertOrderSetting(order.getSetting()) + "";
            for (LixiOrderGift gift : order.getGifts()) {

                try {

                    if (EnumLixiOrderStatus.GiftStatus.UN_SUBMITTED.getValue().equals(gift.getBkSubStatus())) {
                        String receiverName = StringUtils.join(new String[]{gift.getRecipient().getFirstName(), gift.getRecipient().getMiddleName(), gift.getRecipient().getLastName()}, " ");
                        /**
                         *
                         * Setting up data to be sent to REST service
                         *
                         */
                        MultiValueMap<String, String> vars = new LinkedMultiValueMap<>();
                        vars.add("lixi_order_id", order.getId().toString());
                        vars.add("order_id", gift.getId().toString());
                        vars.add("sender_name", senderName);
                        vars.add("sender_email", senderEmail);
                        vars.add("sender_phone", senderPhone);
                        vars.add("product_id", gift.getProductId() + "");
                        vars.add("price", gift.getProductPrice() + "");
                        vars.add("quantity", gift.getProductQuantity() + "");
                        vars.add("receiver_name", receiverName);
                        vars.add("receiver_email", emptyIfNull(gift.getRecipient().getEmail()));
                        vars.add("receiver_phone", emptyIfNull(LiXiGlobalUtils.checkZeroAtBeginOfPhoneNumber(gift.getRecipient().getPhone())));
                        vars.add("receiver_adress", "INPUT_BY_BAOKIM");// TODO: add address to recipient
                        vars.add("message", gift.getRecipient().getNote());
                        vars.add("method_receive", methodReceive);
                        //
                        log.info("///////////////////////////////////////////////////");
                        log.info("lixi_order_id: " + order.getId().toString());
                        log.info("order_id:" + gift.getId().toString());
                        log.info("sender_name:" + senderName);
                        log.info("sender_email:" + senderEmail);
                        log.info("sender_phone:" + senderPhone);
                        log.info("product_id:" + gift.getProductId() + "");
                        log.info("price:" + gift.getProductPrice() + "");
                        log.info("quantity:" + gift.getProductQuantity() + "");
                        log.info("receiver_name:" + receiverName);
                        log.info("receiver_email:" + emptyIfNull(gift.getRecipient().getEmail()));
                        log.info("receiver_phone:" + emptyIfNull(LiXiGlobalUtils.checkZeroAtBeginOfPhoneNumber(gift.getRecipient().getPhone())));
                        log.info("receiver_adress: INPUT_BY_BAOKIM");
                        log.info("message:" + gift.getRecipient().getNote());
                        log.info("method_receive:" + methodReceive);
                        //log.info("shipping_fee" + vndShip+"");
                        log.info("///////////////////////////////////////////////////");

                        LixiSubmitOrderResult result = restTemplate.postForObject(submitUrl, vars, LixiSubmitOrderResult.class);

                        gift.setBkStatus(EnumLixiOrderStatus.PROCESSING.getValue());
                        gift.setBkSubStatus(EnumLixiOrderStatus.GiftStatus.SENT_INFO.getValue());
                        gift.setBkMessage(result.getData().getMessage());
                        gift.setModifiedDate(Calendar.getInstance().getTime());
                        
                        log.info("bk message:" + result.getData().getMessage());
                        log.info("order id:" + result.getData().getOrder_id());
                        log.info("///////////////////////////////////////////////////");
                        // update
                        orderGiftService.save(gift);
                    }
                } catch (Exception e) {
                    // error
                    gift.setBkStatus(EnumLixiOrderStatus.GiftStatus.UN_SUBMITTED.getValue());
                    gift.setBkMessage(e.getMessage());
                    // update
                    orderGiftService.save(gift);
                    // don't update order status
                    updateOrderStatus = false;

                    // log error
                    log.info(e.getMessage(), e);
                    emailBaoKimSystemError(SUBJECT, ExceptionUtils.getStackTrace(e).replaceAll("(\r\n|\n)", "<br />"));
                }
            }

            // update order
            log.info("updateOrderStatus: " + updateOrderStatus);

            if (updateOrderStatus) {

                order.setLixiStatus(EnumLixiOrderStatus.PROCESSING.getValue());
                order.setLixiSubStatus(EnumLixiOrderStatus.GiftStatus.SENT_INFO.getValue());
                order.setLixiMessage("Sent Order Info");
                order.setModifiedDate(Calendar.getInstance().getTime());
                
                orderService.save(order);

            }
        } catch (Exception e) {

            log.info(e.getMessage(), e);
            emailBaoKimSystemError(SUBJECT, ExceptionUtils.getStackTrace(e).replaceAll("(\r\n|\n)", "<br />"));
        }

    }

    /**
     * 
     * @param order
     * @return boolean
     */
    public boolean reSubmitOrdersToBaoKim(LixiOrder order) {

        // check properties is null
        if (baokimProp == null) {
            return false;
        }
        if (order == null) {
            return false;
        }
        if (order.getGifts() == null || order.getGifts().isEmpty()) {
            return false;
        }
        boolean updateOrderStatus = true;
        //
        try {

            final AuthHttpComponentsClientHttpRequestFactory requestFactory
                    = new AuthHttpComponentsClientHttpRequestFactory(
                            HttpClients.createDefault(), HttpHost.create(baokimProp.getProperty("baokim.host")), baokimProp.getProperty("baokim.username"), baokimProp.getProperty("baokim.password"));

            final RestTemplate restTemplate = new RestTemplate(requestFactory);

            String submitUrl = baokimProp.getProperty("baokim.submit_order");
            String senderName = StringUtils.join(new String[]{order.getSender().getFirstName(), order.getSender().getMiddleName(), order.getSender().getLastName()}, " ");
            String senderEmail = order.getSender().getEmail();
            String senderPhone = emptyIfNull(order.getSender().getPhone());
            String methodReceive = convertOrderSetting(order.getSetting()) + "";
            for (LixiOrderGift gift : order.getGifts()) {

                try {
                    // do not re-send complete or cancelled gift
                        if (EnumLixiOrderStatus.GiftStatus.UN_SUBMITTED.getValue().equals(gift.getBkSubStatus()) || 
                            EnumLixiOrderStatus.GiftStatus.SENT_INFO.getValue().equals(gift.getBkSubStatus()) ||   
                            EnumLixiOrderStatus.GiftStatus.SENT_MONEY.getValue().equals(gift.getBkSubStatus())) {
                            String receiverName = StringUtils.join(new String[]{gift.getRecipient().getFirstName(), gift.getRecipient().getMiddleName(), gift.getRecipient().getLastName()}, " ");
                            /**
                             *
                             * Setting up data to be sent to REST service
                             *
                             */
                            MultiValueMap<String, String> vars = new LinkedMultiValueMap<>();
                            vars.add("lixi_order_id", order.getId().toString());
                            vars.add("order_id", gift.getId().toString());
                            vars.add("sender_name", senderName);
                            vars.add("sender_email", senderEmail);
                            vars.add("sender_phone", senderPhone);
                            vars.add("product_id", gift.getProductId() + "");
                            vars.add("price", gift.getProductPrice() + "");
                            vars.add("quantity", gift.getProductQuantity() + "");
                            vars.add("receiver_name", receiverName);
                            vars.add("receiver_email", emptyIfNull(gift.getRecipient().getEmail()));
                            vars.add("receiver_phone", emptyIfNull(LiXiGlobalUtils.checkZeroAtBeginOfPhoneNumber(gift.getRecipient().getPhone())));
                            vars.add("receiver_adress", "INPUT_BY_BAOKIM");// TODO: add address to recipient
                            vars.add("message", gift.getRecipient().getNote());
                            vars.add("method_receive", methodReceive);
                            //
                            log.info("///////////////////////////////////////////////////");
                            log.info("lixi_order_id:" +  order.getId().toString());
                            log.info("order_id:" + gift.getId().toString());
                            log.info("sender_name:" + senderName);
                            log.info("sender_email:" + senderEmail);
                            log.info("sender_phone:" + senderPhone);
                            log.info("product_id:" + gift.getProductId() + "");
                            log.info("price:" + gift.getProductPrice() + "");
                            log.info("quantity:" + gift.getProductQuantity() + "");
                            log.info("receiver_name:" + receiverName);
                            log.info("receiver_email:" + emptyIfNull(gift.getRecipient().getEmail()));
                            log.info("receiver_phone:" + emptyIfNull(LiXiGlobalUtils.checkZeroAtBeginOfPhoneNumber(gift.getRecipient().getPhone())));
                            log.info("receiver_adress:INPUT_BY_BAOKIM");
                            log.info("message:" + gift.getRecipient().getNote());
                            log.info("method_receive:" + methodReceive);
                            log.info("///////////////////////////////////////////////////");

                            LixiSubmitOrderResult result = restTemplate.postForObject(submitUrl, vars, LixiSubmitOrderResult.class);

                            log.info("resend bk message:" + result.getData().getMessage());
                            log.info("order id:" + result.getData().getOrder_id());
                            log.info("///////////////////////////////////////////////////");
                        }
                } catch (Exception e) {
                    updateOrderStatus = false;

                    // log error
                    log.info(e.getMessage(), e);
                    emailBaoKimSystemError(SUBJECT, ExceptionUtils.getStackTrace(e).replaceAll("(\r\n|\n)", "<br />"));
                }
            }

        } catch (Exception e) {
            updateOrderStatus = false;
            log.info(e.getMessage(), e);
            emailBaoKimSystemError(SUBJECT, ExceptionUtils.getStackTrace(e).replaceAll("(\r\n|\n)", "<br />"));
        }
        
        return updateOrderStatus;
    }
    /**
     *
     * @param order
     * @return 
     */
    public boolean cancelOrderOnBaoKim(LixiOrder order) {

        // check properties is null
        if (baokimProp == null) {
            return false;
        }
        if (order == null) {
            return true;
        }
        if (order.getGifts() == null || order.getGifts().isEmpty()) {
            return true;
        }
        //
        boolean updateOrderStatus = true;
        try {

            final AuthHttpComponentsClientHttpRequestFactory requestFactory
                    = new AuthHttpComponentsClientHttpRequestFactory(
                            HttpClients.createDefault(), HttpHost.create(baokimProp.getProperty("baokim.host")), baokimProp.getProperty("baokim.username"), baokimProp.getProperty("baokim.password"));

            final RestTemplate restTemplate = new RestTemplate(requestFactory);

            String submitUrl = baokimProp.getProperty("baokim.cancel_order");
            SimpleDateFormat dFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            for (LixiOrderGift gift : order.getGifts()) {

                try {

                    /**
                     *
                     * Setting up data to be sent to REST service
                     *
                     */
                    MultiValueMap<String, String> vars = new LinkedMultiValueMap<>();
                    vars.add("order_id", gift.getId().toString());
                    //
                    log.info("///////////////////////////////////////////////////");
                    log.info("Cancel order on baokim");
                    log.info("order_id:" + gift.getId().toString());
                    log.info("///////////////////////////////////////////////////");

                    LixiSubmitOrderResult result = restTemplate.postForObject(submitUrl, vars, LixiSubmitOrderResult.class);

                    Date dt = Calendar.getInstance().getTime();
                    
                    gift.setBkStatus(EnumLixiOrderStatus.CANCELED.getValue());
                    gift.setBkMessage(result.getData().getMessage());
                    gift.setBkUpdated(dFormat.format(dt));
                    gift.setModifiedDate(dt);
                    
                    log.info("bk message:" + result.getData().getMessage());
                    log.info("order id:" + result.getData().getOrder_id());
                    log.info("///////////////////////////////////////////////////");
                    // update
                    orderGiftService.save(gift);
                } catch (Exception e) {
                    // don't update order status
                    updateOrderStatus = false;

                    // log error
                    log.info(e.getMessage(), e);
                    //log.debug(e.getMessage(), e);
                    emailBaoKimSystemError(SUBJECT, ExceptionUtils.getStackTrace(e).replaceAll("(\r\n|\n)", "<br />"));
                }
            }

            // update order
            if (updateOrderStatus) {

                order.setLixiStatus(EnumLixiOrderStatus.CANCELED.getValue());
                order.setLixiMessage("The Order has been canceled on BaoKim Service");
                order.setModifiedDate(Calendar.getInstance().getTime());
                
                orderService.save(order);

            }
        } catch (Exception e) {

            log.info(e.getMessage(), e);
            //log.debug(e.getMessage(), e);
            emailBaoKimSystemError(SUBJECT, ExceptionUtils.getStackTrace(e).replaceAll("(\r\n|\n)", "<br />"));
        }
        
        return updateOrderStatus;
    }

    /**
     *
     * @param order
     */
    public boolean sendPaymentInfoToBaoKim(LixiOrder order) {

        // check properties is null
        if (baokimProp == null) {
            return false;
        }
        if (order == null) {
            return false;
        }
        if (order.getGifts() == null || order.getGifts().isEmpty()) {
            return false;
        }
        //
        boolean updateOrderStatus = true;
        try {

            final AuthHttpComponentsClientHttpRequestFactory requestFactory
                    = new AuthHttpComponentsClientHttpRequestFactory(
                            HttpClients.createDefault(), HttpHost.create(baokimProp.getProperty("baokim.host")), baokimProp.getProperty("baokim.username"), baokimProp.getProperty("baokim.password"));

            final RestTemplate restTemplate = new RestTemplate(requestFactory);

            String submitUrl = baokimProp.getProperty("baokim.single_payment_notification");
            int setting = order.getSetting();
            SimpleDateFormat dFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            double baoKimPercent = getBaoKimPercent();
            for (LixiOrderGift gift : order.getGifts()) {

                try {
                    if (EnumLixiOrderStatus.GiftStatus.SENT_INFO.getValue().equals(gift.getBkSubStatus())) {
                        String id = gift.getId().toString();
                        String amount = (gift.getProductPrice()*gift.getProductQuantity()) + "";
                        //
                        if(setting == EnumLixiOrderSetting.GIFT_ONLY.getValue() || 
                                /* receiver choose gifted */
                            LiXiGlobalConstants.BAOKIM_GIFT_METHOD.equalsIgnoreCase(gift.getBkReceiveMethod())){
                            
                            double amountNumber = (gift.getProductPrice()*gift.getProductQuantity() * baoKimPercent)/100.0;
                            
                            amount = amountNumber + "";
                        }
                        
                        String dateTransf = dFormat.format(Calendar.getInstance().getTime());
                        /**
                         *
                         * Setting up data to be sent to REST service
                         *
                         */
                        MultiValueMap<String, String> vars = new LinkedMultiValueMap<>();
                        vars.add("lixi_order_id", order.getId().toString());
                        vars.add("order_id", gift.getId().toString());
                        vars.add("amount", amount);
                        vars.add("date_transfer", dateTransf);
                        //
                        log.info("///////////////////////////////////////////////////");
                        log.info("sent money order");
                        log.info("lixi_order_id:" + order.getId().toString());
                        log.info("order_id:" + gift.getId().toString());
                        log.info("amount:" + amount);
                        log.info("date_transfer:" + dateTransf);
                        log.info("///////////////////////////////////////////////////");

                        LixiSubmitOrderResult result = restTemplate.postForObject(submitUrl, vars, LixiSubmitOrderResult.class);

                        gift.setBkStatus(EnumLixiOrderStatus.PROCESSING.getValue());
                        gift.setBkSubStatus(EnumLixiOrderStatus.GiftStatus.SENT_MONEY.getValue());
                        gift.setBkMessage(result.getData().getMessage());
                        gift.setModifiedDate(Calendar.getInstance().getTime());
                        if(LiXiGlobalConstants.BAOKIM_GIFT_METHOD.equalsIgnoreCase(gift.getBkReceiveMethod())){
                            gift.setLixiMargined(true);
                        }
                        log.info("Lixi margined GIFT ID:"+gift.getId());
                        log.info("bk message:" + result.getData().getMessage());
                        log.info("lixi order id:" + result.getData().getLixi_order_id());
                        log.info("order id:" + result.getData().getOrder_id());
                        log.info("///////////////////////////////////////////////////");
                        // update
                        orderGiftService.save(gift);
                    }
                } catch (Exception e) {
                    // error
                    gift.setBkSubStatus(EnumLixiOrderStatus.GiftStatus.SENT_INFO.getValue());
                    gift.setBkMessage(e.getMessage());
                    // update
                    orderGiftService.save(gift);
                    // don't update order status
                    updateOrderStatus = false;

                    // log error
                    log.info(e.getMessage(), e);
                    emailBaoKimSystemError(SUBJECT, ExceptionUtils.getStackTrace(e).replaceAll("(\r\n|\n)", "<br />"));
                }
            }

            // update order
            if (updateOrderStatus) {

                order.setLixiStatus(EnumLixiOrderStatus.PROCESSING.getValue());
                order.setLixiSubStatus(EnumLixiOrderStatus.GiftStatus.SENT_MONEY.getValue());
                order.setLixiMessage("Sent Payment Information");
                order.setModifiedDate(Calendar.getInstance().getTime());
                
                orderService.save(order);
                
                //
            }
            
            /* check order status */
            checkOrderStatus(order);
            
            
        } catch (Exception e) {

            log.info(e.getMessage(), e);
            emailBaoKimSystemError(SUBJECT, ExceptionUtils.getStackTrace(e).replaceAll("(\r\n|\n)", "<br />"));
        }
        
        return updateOrderStatus;
    }
    
    /**
     * 
     * @param order
     */
    public boolean checkOrderStatus(LixiOrder order){
        // check properties is null
        if (baokimProp == null) {
            return false;
        }
        if (order == null) {
            return false;
        }
        if (order.getGifts() == null || order.getGifts().isEmpty()) {
            return false;
        }
        //
        boolean updateOrderStatus = true;
        String lixiOrderStatus = EnumLixiOrderStatus.PROCESSING.getValue();
        try {

            final AuthHttpComponentsClientHttpRequestFactory requestFactory
                    = new AuthHttpComponentsClientHttpRequestFactory(
                            HttpClients.createDefault(), HttpHost.create(baokimProp.getProperty("baokim.host")), baokimProp.getProperty("baokim.username"), baokimProp.getProperty("baokim.password"));

            final RestTemplate restTemplate = new RestTemplate(requestFactory);

            String submitUrl = baokimProp.getProperty("baokim.check_order_status");
            for (LixiOrderGift gift : order.getGifts()) {
                try {
                    if (!EnumLixiOrderStatus.GiftStatus.UN_SUBMITTED.getValue().equals(gift.getBkSubStatus())) {
                        String id = gift.getId().toString();
                        /**
                         *
                         * Setting up data to be sent to REST service
                         *
                         */
                        MultiValueMap<String, String> vars = new LinkedMultiValueMap<>();
                        vars.add("order_id", gift.getId().toString());
                        log.info("///////////////////////////////////////////////////");
                        log.info("check order status ");
                        log.info("GIFT order_id:" + gift.getId().toString());
                        log.info("///////////////////////////////////////////////////");

                        LixiCheckStatusResult result = restTemplate.postForObject(submitUrl, vars, LixiCheckStatusResult.class);
                        
                        //
                        lixiOrderStatus = result.getData().getStatus();
                        //
                        gift.setBkStatus(result.getData().getStatus());
                        gift.setBkReceiveMethod(result.getData().getReceive_method());
                        gift.setBkMessage(result.getData().getMessage());
                        gift.setBkUpdated(result.getData().getUpdated_on());
                        
                        log.info("Check Order Status Result:" + result.getData().toString());
                        log.info("///////////////////////////////////////////////////");
                        // update
                        orderGiftService.save(gift);
                    }
                } catch (Exception e) {
                    log.info(e.getMessage(), e);
                    updateOrderStatus = false;
                }
            }

            // update order
            if(getOrderStatus(order, EnumLixiOrderStatus.COMPLETED.getValue())){
                log.info("Do checkOrderStatus: " + order.getId() + " : " + lixiOrderStatus);
                /* */
                order.setLixiStatus(EnumLixiOrderStatus.COMPLETED.getValue());
                orderService.save(order);
            }
            
        } catch (Exception e) {

            log.info(e.getMessage(), e);
        }
        
        return updateOrderStatus;
    }
    
    /**
     * 
     * @param order
     * @param status
     * @return 
     */
    private boolean getOrderStatus(LixiOrder order, String status){
        for(LixiOrderGift gift : order.getGifts()){
            if(!status.equals(gift.getBkStatus())){
                return false;
            }
        }
        
        for(TopUpMobilePhone t : order.getTopUpMobilePhones()){
            if(!status.equals(t.getStatus())){
                return false;
            }
        }
        
        return true;
    }
    
    /**
     * 
     * @return 
     */
    private double getBaoKimPercent(){
        
        LixiConfig baoKimPercentConfig = configService.findByName(LiXiGlobalConstants.LIXI_BAOKIM_TRANFER_PERCENT);
        double baoKimPercent = 100.0;
        try {
            baoKimPercent = Double.parseDouble(baoKimPercentConfig.getValue());
        } catch (Exception e) {}
        
        return baoKimPercent;
    }
}
