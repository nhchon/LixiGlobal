/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.beans;

import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.mail.internet.MimeMessage;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.ws.WebServiceException;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.BuyCard;
import vn.chonsoft.lixi.model.BuyCardResult;
import vn.chonsoft.lixi.model.DauSo;
import vn.chonsoft.lixi.model.LixiCashrun;
import vn.chonsoft.lixi.model.LixiConfig;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.TopUpMobilePhone;
import vn.chonsoft.lixi.model.TopUpResult;
import vn.chonsoft.lixi.model.VtcResponseCode;
import vn.chonsoft.lixi.model.VtcServiceCode;
import vn.chonsoft.lixi.repositories.service.BuyCardResultService;
import vn.chonsoft.lixi.repositories.service.BuyCardService;
import vn.chonsoft.lixi.repositories.service.DauSoService;
import vn.chonsoft.lixi.repositories.service.LixiCashrunService;
import vn.chonsoft.lixi.repositories.service.LixiConfigService;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.TopUpMobilePhoneService;
import vn.chonsoft.lixi.repositories.service.TopUpResultService;
import vn.chonsoft.lixi.repositories.service.VtcResponseCodeService;
import vn.chonsoft.lixi.repositories.service.VtcServiceCodeService;
import vn.chonsoft.lixi.repositories.util.LiXiVatGiaUtils;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.util.LiXiUtils;
import vn.vtc.pay.RequestTransactionResponse;

/**
 *
 * @author chonnh
 */
public class LixiAsyncMethodsImpl implements LixiAsyncMethods {

    private static final Logger log = LogManager.getLogger(LixiAsyncMethodsImpl.class);

    @Autowired
    private LixiOrderService orderService;

    @Autowired
    private LixiOrderGiftService orderGiftService;

    @Autowired
    private DauSoService dauSoService;

    @Autowired
    private LixiCashrunService cashRunService;

    @Autowired
    private VtcServiceCodeService vtcServiceCodeService;

    @Autowired
    private VtcPayClient vtcClient;

    @Autowired
    private TopUpMobilePhoneService topUpService;

    @Autowired
    private TopUpResultService turService;

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private ThreadPoolTaskScheduler taskScheduler;

    @Autowired
    private VelocityEngine velocityEngine;

    @Autowired
    private VtcResponseCodeService responseCodeService;

    @Autowired
    private BuyCardResultService bcrService;

    @Autowired
    private BuyCardService bcService;

    @Autowired
    private LiXiVatGiaUtils lxVatGiaUtils;
    
    @Autowired
    private LixiConfigService configService;
    
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
    
    @Override
    @Async
    public void cashRunTransactionStatusUpdate(String userAgent, long invoiceId, long orderId, String amount, String currency){
        
        try {
        Connection conn = Jsoup.connect(LiXiGlobalConstants.CASHRUN_PRODUCTION_PAGE_TRANSACTION_STATUS_UPDATE).timeout(0).maxBodySize(0);
        Connection.Response doc = conn.data("SITE_ID", "2b57448f3013fc513dcc7a4ab933e6928ab74672")
            .data("API_KEY", "UkX5P9GIOL3ruCzMYRKFDJvQxbV86wpa")
            .data("ORDER_ID", orderId+"")
            .data("AMOUNT", amount)
            .data("CURRENCY", "USD")
            .data("PAYMENT_STATUS", "1")
            .ignoreContentType(true)
            //"Mozilla"
            .userAgent(userAgent)
            .method(Connection.Method.POST)
            .execute();
            //.post();
        
        log.info("CashShield Post Transaction Status Update: " + doc.body());

        LixiCashrun lxCashRun = new LixiCashrun();
        
        lxCashRun.setActionType("CashShield Post Transaction Status Update");
        lxCashRun.setCashrun(doc.body());
        lxCashRun.setInvId(invoiceId);
        lxCashRun.setOrderId(orderId);
        lxCashRun.setCreatedDate(Calendar.getInstance().getTime());

        this.cashRunService.save(lxCashRun);
        } catch (Exception e) {
            log.info("Post Transaction Status Update URL:", e);
        }
        
    }

    /**
     * 
     * @param lixiOrderId
     * @param status 
     */
    @Async
    @Override
    public void updateLixiOrderStatus(Long lixiOrderId, String status){
        
        log.info("Call updateLixiOrderStatus: " + lixiOrderId + " : " + status);
        
        LixiOrder order = this.orderService.findById(lixiOrderId);
        if(getOrderStatus(order, status)){
            log.info("Do updateLixiOrderStatus: " + order.getId() + " : " + status);
            /* */
            order.setLixiStatus(status);
            orderService.save(order);
        }
        
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
        
        //for(TopUpMobilePhone t : order.getTopUpMobilePhones()){
        //    if(!status.equals(t.getStatus())){
        //        return false;
        //    }
        //}
        
        return true;
    }
    
    /**
     * 
     * @return 
     */
    @Override
    public boolean checkBaoKimSystem() {
        
        return lxVatGiaUtils.getVatGiaCategory() != null;
        
    }

    @Override
    public boolean reSubmitOrdersToBaoKimNoAsync(LixiOrder order){
        return lxVatGiaUtils.reSubmitOrdersToBaoKim(order);
    }
    
    /**
     *
     * @param order
     */
    @Override
    @Async
    public void submitOrdersToBaoKim(LixiOrder order) {

        lxVatGiaUtils.submitOrdersToBaoKim(order);

    }

    @Override
    public void submitOrdersToBaoKimNoAsync(LixiOrder order) {

        lxVatGiaUtils.submitOrdersToBaoKim(order);

    }

    /**
     * 
     * @param order 
     */
    @Override
    public boolean cancelOrdersOnBaoKimNoAsync(LixiOrder order){
        
        return lxVatGiaUtils.cancelOrderOnBaoKim(order);
        
    }

    
    /**
     * 
     * @param order 
     */
    @Override
    public boolean sendPaymentInfoToBaoKim(LixiOrder order){
        
        boolean rs = lxVatGiaUtils.sendPaymentInfoToBaoKim(order);
        
        if(rs){
            lxVatGiaUtils.sendShippingFee(LiXiUtils.genMapRecGifts(order, getBaoKimPercent()));
        }
        
        return rs;//lxVatGiaUtils.sendPaymentInfoToBaoKim(order);
    }
    
    /**
     *
     * @param phone
     * @return
     */
    private DauSo getDauSo(String phone) {

        // check phone number belongs to which networks ?
        if (!phone.startsWith("0")) {
            phone = "0" + phone;
        }
        // check first three numbers
        List<DauSo> dauSos = dauSoService.findByCode(StringUtils.substring(phone, 0, 3));
        if (dauSos.isEmpty()) {
            //check four numbers
            dauSos = dauSoService.findByCode(StringUtils.substring(phone, 0, 4));
        }

        return dauSos.get(0);
    }

    /**
     * 
     * @param topUp
     * @return 
     */
    private String doProcessTopUp(TopUpMobilePhone topUp){
        
        Recipient rec = topUp.getRecipient();
        String amount = new Long((long)topUp.getAmount()).toString();//"10000";
        String account = LiXiGlobalUtils.checkZeroAtBeginOfPhoneNumber(topUp.getPhone()); // phone number

        DauSo dauSo = getDauSo(account);
        //if(!dauSos.isEmpty()){

        VtcServiceCode serviceCode = this.vtcServiceCodeService.findByNetworkAndLxChucNang(dauSo.getNetwork(), LiXiConstants.NAP_TIEN_TRA_TRUOC);

        String requestData = vtcClient.topUpRequestData(topUp.getId(), serviceCode.getCode(), account, amount);
        
        log.info("request data: " + requestData);
        
        RequestTransactionResponse response = null;
        try {
            // call vtc's service
            response = vtcClient.topupTelco(requestData);

        } catch (WebServiceException e) {
            log.info(e.getMessage(), e);
            /* handle exception */
            // update topup
            topUp.setStatus(EnumLixiOrderStatus.TopUpStatus.UN_SUBMITTED.getValue());// submit failed
            topUp.setResponseCode(-1);
            topUp.setResponseMessage(e.getMessage());
            topUp.setModifiedDate(Calendar.getInstance().getTime());
            
            this.topUpService.save(topUp);

            // email to sender, receiver, admin
            return "-1";
        }

        if (response != null) {
            // <ResponseCode>|<OrgTransID>|<PartnerBalance>|<DataSign>
            String vtcReturned = response.getRequestTransactionResult();
            log.info(vtcReturned);

            // save result into database
            TopUpResult tur = new TopUpResult();
            tur.setTopUp(topUp);
            tur.setRequestData(requestData);
            tur.setResponseData(vtcReturned);
            tur.setTopUp(topUp);
            tur.setModifiedDate(Calendar.getInstance().getTime());

            this.turService.save(tur);

            // parse result
            String[] results = vtcReturned.split("\\|");
            if (LiXiConstants.VTC_OK.equals(results[0])) {
                // update topup
                topUp.setStatus(EnumLixiOrderStatus.COMPLETED.getValue());
                topUp.setResponseCode(1);//OK
                topUp.setResponseMessage("OK");
                topUp.setModifiedDate(Calendar.getInstance().getTime());

                this.topUpService.save(topUp);
                
                // update order status
                updateLixiOrderStatus(topUp.getOrder().getId(), EnumLixiOrderStatus.COMPLETED.getValue());
                
                // send email
                MimeMessagePreparator preparator = new MimeMessagePreparator() {
                    @SuppressWarnings({"rawtypes", "unchecked"})
                    @Override
                    public void prepare(MimeMessage mimeMessage) throws Exception {
                        MimeMessageHelper message = new MimeMessageHelper(mimeMessage, "UTF-8");
                        message.setTo(rec.getEmail());
                        //message.setCc(LiXiGlobalConstants.CHONNH_GMAIL);
                        //message.addCc(LiXiGlobalConstants.YHANNART_GMAIL);
                        message.setFrom("support@lixi.global");
                        message.setSubject("LiXi.Global - Top Up Mobile Minutes Alert");
                        message.setSentDate(Calendar.getInstance().getTime());

                        Map model = new HashMap();
                        model.put("rec", rec);
                        model.put("sender", topUp.getOrder().getSender());
                        model.put("amount", LiXiUtils.getNumberFormat().format(topUp.getAmount()));

                        String text = VelocityEngineUtils.mergeTemplateIntoString(
                                velocityEngine, "emails/topup-confirmation.vm", "UTF-8", model);
                        message.setText(text, true);
                    }
                };
                // send oldEmail
                taskScheduler.execute(() -> mailSender.send(preparator));
                
                return LiXiConstants.VTC_OK;
            }// enf if TOP UP is OK
            else {

                // what to do if VTC TOP UP is failed ???
                // update topup
                VtcResponseCode vtcResponse = this.responseCodeService.findByCode(Integer.parseInt(results[0]));

                topUp.setStatus(EnumLixiOrderStatus.TopUpStatus.UN_SUBMITTED.getValue());// error, can not sent
                topUp.setResponseCode(vtcResponse.getCode());//OK
                topUp.setResponseMessage(vtcResponse.getDescription());
                topUp.setModifiedDate(Calendar.getInstance().getTime());

                this.topUpService.save(topUp);
            }
        }
        /* */
        return "-1";
    }
    /**
     * 
     * @param topUp 
     * @return
     */
    @Override
    @Async
    public String processTopUpItem(TopUpMobilePhone topUp) {
        
        return doProcessTopUp(topUp);
    }

    /**
     * 
     * @param topUp
     * @return 
     */
    @Override
    public String processTopUpItemNoAsync(TopUpMobilePhone topUp){
         return doProcessTopUp(topUp);
    }
    /**
     *
     * @param order
     */
    @Override
    @Async
    public void processTopUpItems(LixiOrder order) {

        for (TopUpMobilePhone topUp : order.getTopUpMobilePhones()) {
            doProcessTopUp(topUp);
        }// forEach topUps

    }

    /**
     *
     * @param order
     */
    @Override
    @Async
    public void processBuyCardItems(LixiOrder order) {
        log.info("buyCard is empty:" + order.getBuyCards().isEmpty());

        for (BuyCard bc : order.getBuyCards()) {

            Long id = bc.getId();
            Recipient rec = bc.getRecipient();
            String amount = "10000";
            String quantity = "1";

            DauSo dauSo = getDauSo(rec.getPhone());
            VtcServiceCode serviceCode = this.vtcServiceCodeService.findByNetworkAndLxChucNang(dauSo.getNetwork(), LiXiConstants.MUA_LAY_THE_CAO);

            String requestData = vtcClient.buyCardRequestData(id, serviceCode.getCode(), amount, quantity);
            RequestTransactionResponse response = vtcClient.buyCard(requestData);
            String vtcReturned = response.getRequestTransactionResult();

            log.info("buyCard: " + vtcReturned);

            BuyCardResult bcr = new BuyCardResult();
            bcr.setBuyCard(bc);
            bcr.setBuyRequest(requestData);
            bcr.setBuyResponse(vtcReturned);
            bcr.setModifiedDate(Calendar.getInstance().getTime());
            bcr = this.bcrService.save(bcr);
            String[] rs = vtcReturned.split("\\|");
            if (LiXiConstants.VTC_OK.equals(rs[0])) {

                try {
                    // VTCTransID
                    String vtcTransId = rs[2];
                    log.info("vtcTransId: " + vtcTransId);
                    // generate request data
                    String getCardRequestData = vtcClient.getCardData(vtcTransId, serviceCode.getCode(), amount);

                    log.info("getCardRequestData: " + getCardRequestData);

                    // cal vtc's get card service
                    RequestTransactionResponse getCardRresponse = vtcClient.getCard(getCardRequestData);
                    // 
                    String getCardRReturned = getCardRresponse.getRequestTransactionResult();
                    log.info("getCardRReturned: " + getCardRReturned);

                    // dycrept
                    String getCardDecrypt = vtcClient.decryptTripleDES(getCardRReturned);
                    log.info("getCardDecrypt: " + getCardDecrypt);

                    // store into db
                    bcr.setGetRequest(getCardRequestData);
                    bcr.setGetResponse(getCardRReturned);
                    bcr.setGetResponseDecrypt(getCardDecrypt);

                    bcr.setModifiedDate(Calendar.getInstance().getTime());

                    this.bcrService.save(bcr);
                    //
                    String[] rss = getCardDecrypt.split("\\|");
                    log.info("rss.length: " + rss.length);

                    String[] cards = new String[rss.length - 2];

                    System.arraycopy(rss, 2, cards, 0, cards.length);

                    if (LiXiConstants.VTC_OK.equals(rss[0])) {
                        // update buycard
                        bc.setIsSubmitted(1);
                        bc.setResponseCode(1);// OK
                        bc.setResponseMessage("OK");

                        this.bcService.save(bc);

                        // add type of card
                        for (int i = 0; i < cards.length; i++) {
                            cards[i] = serviceCode.getName() + " " + cards[i];
                        }
                        // send email
                        MimeMessagePreparator preparator = new MimeMessagePreparator() {
                            @SuppressWarnings({"rawtypes", "unchecked"})
                            @Override
                            public void prepare(MimeMessage mimeMessage) throws Exception {
                                MimeMessageHelper message = new MimeMessageHelper(mimeMessage, "UTF-8");
                                message.setTo(rec.getEmail());
                                message.setCc(LiXiGlobalConstants.CHONNH_GMAIL);
                                message.setFrom("support@lixi.global");
                                message.setSubject("LiXi.Global - Phone Cards Alert");
                                message.setSentDate(Calendar.getInstance().getTime());

                                Map model = new HashMap();
                                model.put("rec", rec);
                                model.put("sender", order.getSender());
                                model.put("numOfCard", bc.getNumOfCard());
                                model.put("valueOfCard", bc.getValueOfCard());
                                model.put("cards", Arrays.asList(cards));

                                String text = VelocityEngineUtils.mergeTemplateIntoString(
                                        velocityEngine, "emails/buycard-alert.vm", "UTF-8", model);

                                message.setText(text, true);
                            }
                        };
                        // send oldEmail
                        taskScheduler.execute(() -> mailSender.send(preparator));
                    } else {

                        // what to do when getcard is failed
                        // update buycard item
                        VtcResponseCode vtcResponse = this.responseCodeService.findByCode(Integer.parseInt(rss[0]));
                        bc.setIsSubmitted(1);
                        bc.setResponseCode(vtcResponse.getCode());
                        bc.setResponseMessage(vtcResponse.getDescription());

                        this.bcService.save(bc);
                        //

                    }
                } catch (Exception e) {

                    log.info(" Get Card failed : " + e.getMessage(), e);

                    // update buycard item
                    bc.setIsSubmitted(1);
                    bc.setResponseCode(-999999);
                    bc.setResponseMessage(" Get Card failed : " + e.getMessage());

                    this.bcService.save(bc);
                }
            } else {

                // what to do when buy card failed
                // update buycard
                VtcResponseCode vtcResponse = this.responseCodeService.findByCode(Integer.parseInt(rs[0]));
                bc.setIsSubmitted(1);
                bc.setResponseCode(vtcResponse.getCode());// OK
                bc.setResponseMessage(vtcResponse.getDescription());

                this.bcService.save(bc);
                //
            }
        }

    }
}
