/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.mail.internet.MimeMessage;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.stereotype.Service;
import org.springframework.ui.velocity.VelocityEngineUtils;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.LixiInvoice;
import vn.chonsoft.lixi.model.LixiMonitor;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.UserCard;

/**
 *
 * @author Asus
 */
@Service
public class TransactionMonitorServiceImpl implements TransactionMonitorService{
    
    @Autowired
    private LixiMonitorService monitor;
    
    @Autowired
    private LixiInvoiceService invService;

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private ThreadPoolTaskScheduler taskScheduler;

    @Autowired
    private VelocityEngine velocityEngine;

    /**
     * 
     * @param content 
     */
    private void mail(String content){
     
        MimeMessagePreparator preparator = new MimeMessagePreparator() {
            @SuppressWarnings({"rawtypes", "unchecked"})
            @Override
            public void prepare(MimeMessage mimeMessage) throws Exception {
                MimeMessageHelper message = new MimeMessageHelper(mimeMessage, "UTF-8");
                message.setTo(LiXiGlobalConstants.YHANNART_GMAIL);
                message.setCc(LiXiGlobalConstants.CHONNH_GMAIL);
                message.setFrom("support@lixi.global");
                message.setSubject("LiXi.Global - Transaction Monitor Alert");
                message.setSentDate(Calendar.getInstance().getTime());

                Map<String, Object> model = new HashMap<>();
                model.put("content", content);
                
                String text = VelocityEngineUtils.mergeTemplateIntoString(
                        velocityEngine, "emails/transaction-monitor.vm", "UTF-8", model);
                message.setText(text, true);
            }
        };
        // send oldEmail
        taskScheduler.execute(() -> mailSender.send(preparator));
    }
    /**
     * 
     * @param order 
     */
    @Override
    @Async
    public void transactions(LixiOrder order){
        
        /* get sender id */
        Long payer = order.getSender().getId();
        String emailPayer = order.getSender().getEmail();
        
        List<LixiInvoice> invs = invService.findByPayerAndInvoiceStatus(payer, LiXiGlobalConstants.TRANS_STATUS_IN_PROGRESS);
        
        if(invs != null){
            if(invs.size()>=2){
                /* more than one order in progress */
                String content = "Tài khoản " + emailPayer + " có " + invs.size() + " transactions are In Progress";
                LixiMonitor m = new LixiMonitor();
                m.setDescription(content);
                m.setProcessed(0);
                m.setUser(order.getSender());
                m.setCreatedDate(Calendar.getInstance().getTime());

                this.monitor.save(m);

                /* mail */
                mail(content);
            }
            
            /* */
            invs.forEach(i -> {
                if(i.getGiftPrice() >= 100.0){
                    String content = "Tài khoản " + emailPayer + " thực hiện đơn hàng " + i.getGiftPrice() + " USD. "
                            + " Transaction ID: " + i.getOrder().getId() + ""
                            + " Authorize.net ID: " + i.getNetTransId();
                    LixiMonitor m = new LixiMonitor();
                    m.setDescription(content);
                    m.setProcessed(0);
                    m.setUser(order.getSender());
                    m.setCreatedDate(Calendar.getInstance().getTime());

                    this.monitor.save(m);

                    /* mail */
                    mail(content);
                }
            });
        }
    }
    /**
     * 
     * @param uc 
     */
    @Override
    @Async
    public void visaCard(UserCard uc){
        
        String nameOnCard = uc.getCardName();
        
        String firstName = uc.getUser().getFirstName();
        String lastName = uc.getUser().getLastName();
        
        if(!nameOnCard.contains(firstName) || !nameOnCard.contains(lastName)){
            
            String cardType = "Visa";
            switch(uc.getCardType()){
                //MASTER(2
                case 2:
                    cardType = "Master";
                    break;
                //DISCOVER(3)
                case 3:
                    cardType = "Discovery";
                    break;
            }
            
            LixiMonitor m = new LixiMonitor();
            String content = "Thẻ " + cardType + "("+uc.getCardNumber()+")" + " không trùng tên đăng ký của account " +
                    uc.getUser().getEmail() +"(" + uc.getUser().getFullName()+")";
            m.setDescription(content);
            m.setProcessed(0);
            m.setUser(uc.getUser());
            m.setCreatedDate(Calendar.getInstance().getTime());
            
            this.monitor.save(m);
            
            /* mail */
            mail(content);
        }
    }
}
