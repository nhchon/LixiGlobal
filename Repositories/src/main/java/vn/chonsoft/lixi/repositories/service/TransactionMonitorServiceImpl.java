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
public class TransactionMonitorServiceImpl implements TransactionMonitorService {

    private static final int MAX_NUM_ORDER = 3;

    private static final int OVER_100_USD = 1;
    private static final int NAME_ON_CARD_WRONG = 2;
    private static final int OVER_MAX_NUM_ORDER = 3;

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
    private void mail(String content) {

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
    public void transactions(LixiOrder order) {

        /* get sender id */
        Long payer = order.getSender().getId();
        String emailPayer = order.getSender().getEmail();

        /* get invoices */
        LixiInvoice inv = this.invService.findByOrder(order);
        if (inv.getTotalAmount() >= 100) {

            inv.setMonitored(OVER_100_USD);
            this.invService.save(inv);
        } else {
            // content
            String mailContent = "Transaction #" + inv.getInvoiceCode() + " need to be reviewed:<br/>"
                    + " By: " + emailPayer + "<br/>"
                    + " Authorize.net ID: " + inv.getNetTransId();
            // check card
            String nameOnCard = order.getCard().getCardName();

            String firstName = order.getSender().getFirstName();
            String lastName = order.getSender().getLastName();

            if (!nameOnCard.contains(firstName) || !nameOnCard.contains(lastName)) {
                inv.setMonitored(NAME_ON_CARD_WRONG);
                this.invService.save(inv);

                //
                mail(mailContent);
            } else {
                List<LixiInvoice> invs = invService.findByPayerAndInvoiceStatus(payer, LiXiGlobalConstants.TRANS_STATUS_IN_PROGRESS);

                if (invs != null && invs.size() >= MAX_NUM_ORDER) {
                    inv.setMonitored(OVER_MAX_NUM_ORDER);
                    this.invService.save(inv);

                    //
                    mail(mailContent);
                }
            }
        }
    }
}
