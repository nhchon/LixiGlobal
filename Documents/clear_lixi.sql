delete FROM `lixi_order_gifts`;
delete FROM `lixi_invoice_payment` where invoice_id=144;
delete FROM `lixi_invoices` where id=144;
delete FROM `lixi_cashrun` where order_id=168;
delete FROM `top_up_result`;
delete FROM `top_up_mobile_phone`;
delete FROM `buy_card_result`;
delete FROM `buy_card`;
delete FROM `lixi_batch_orders`;
delete FROM `lixi_batch`;
delete FROM `lixi_orders`;
delete FROM `lixi_order_cards`;
delete FROM `user_session` ;
Delete FROM `user_secret_code` ;
DELETE FROM `user_money_level`;
DELETE FROM `user_cards` ;
DELETE FROM `user_bank_accounts`;
DELETE FROM `billing_address`;
DELETE FROM `recipients`;
DELETE FROM `billing_address`;
DELETE FROM `lixi_monitor`;
DELETE FROM `users`;
DELETE FROM `customer_comment`;
DELETE FROM `customer_problem_management` ;
DELETE FROM `customer_problem` ;
DELETE FROM `customer_subject` WHERE `customer_subject`.`id` = 2;
DELETE FROM `authorize_customer_result`;
DELETE FROM `authorize_payment_result`;
