/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.config;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Hashtable;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.Executor;
import javax.persistence.SharedCacheMode;
import javax.persistence.ValidationMode;
import javax.sql.DataSource;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.exception.VelocityException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.AdviceMode;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.Ordered;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.lookup.JndiDataSourceLookup;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.oxm.jaxb.Jaxb2Marshaller;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.annotation.AsyncConfigurer;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.ui.velocity.VelocityEngineFactoryBean;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.validation.beanvalidation.MethodValidationPostProcessor;
import org.springframework.web.bind.annotation.ControllerAdvice;
import vn.chonsoft.lixi.repositories.service.LixiCategoryService;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.beans.CategoriesBean;
import vn.chonsoft.lixi.web.beans.VtcPayClient;
import vn.chonsoft.lixi.web.beans.LiXiSecurityManager;
import vn.chonsoft.lixi.web.beans.LixiAsyncMethods;
import vn.chonsoft.lixi.web.beans.LixiAsyncMethodsImpl;
import vn.chonsoft.lixi.web.util.LiXiUtils;
import vn.chonsoft.lixi.web.beans.TripleDES;

/**
 *
 * @author chonnh
 */
@Configuration
@Lazy
@EnableScheduling
@EnableAsync(
        mode = AdviceMode.PROXY, proxyTargetClass = false,
        order = Ordered.HIGHEST_PRECEDENCE
)
@EnableTransactionManagement(
        mode = AdviceMode.PROXY, proxyTargetClass = false,
        order = Ordered.LOWEST_PRECEDENCE
)
@EnableJpaRepositories(
        basePackages = "vn.chonsoft.lixi.repositories",
        entityManagerFactoryRef = "entityManagerFactoryBean",
        transactionManagerRef = "jpaTransactionManager"
)
@ComponentScan(
        basePackages = {"vn.chonsoft.lixi.model", "vn.chonsoft.lixi.repositories"},
        excludeFilters =
        @ComponentScan.Filter({Controller.class, ControllerAdvice.class})
)
@PropertySource(value = { "classpath:lixi.properties",  "classpath:categories.properties"})

@Import({ SecurityConfiguration.class })
public class RootContextConfiguration  implements
        AsyncConfigurer, SchedulingConfigurer{
    
    private static final Logger log = LogManager.getLogger();
    
    private static final Logger schedulingLogger =
            LogManager.getLogger(log.getName() + ".[scheduling]");

    @Autowired
    private Environment env;
    
    @Autowired
    private LixiCategoryService lxCategoryService;
    
    
    @Bean
    public MessageSource messageSource()
    {
        ReloadableResourceBundleMessageSource messageSource =
                new ReloadableResourceBundleMessageSource();
        messageSource.setCacheSeconds(-1);
        messageSource.setDefaultEncoding(StandardCharsets.UTF_8.name());
        messageSource.setBasenames(
                "/WEB-INF/i18n/titles", "/WEB-INF/i18n/messages",
                "/WEB-INF/i18n/errors", "/WEB-INF/i18n/validation"
        );
        return messageSource;
    }

    @Bean
    public LocalValidatorFactoryBean localValidatorFactoryBean()
    {
        LocalValidatorFactoryBean validator = new LocalValidatorFactoryBean();
        validator.setValidationMessageSource(this.messageSource());
        return validator;
    }
    
    @Bean
    public MethodValidationPostProcessor methodValidationPostProcessor()
    {
        MethodValidationPostProcessor processor =
                new MethodValidationPostProcessor();
        processor.setValidator(this.localValidatorFactoryBean());
        return processor;
    }
    
    @Bean
    public ObjectMapper objectMapper()
    {
        ObjectMapper mapper = new ObjectMapper();
        mapper.findAndRegisterModules();
        mapper.configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false);
        mapper.configure(DeserializationFeature.ADJUST_DATES_TO_CONTEXT_TIME_ZONE,
                false);
        return mapper;
    }

    @Bean
    public Jaxb2Marshaller jaxb2Marshaller()
    {
        Jaxb2Marshaller marshaller = new Jaxb2Marshaller();
        marshaller.setPackagesToScan(new String[] { "vn.vtc.pay", "vn.chonsoft.lixi" });
        return marshaller;
    }

    @Bean
    public DataSource lixiGlobalDataSource()
    {
        JndiDataSourceLookup lookup = new JndiDataSourceLookup();
        return lookup.getDataSource(env.getProperty("datasource.name"));
    }

    @Bean
    public LocalContainerEntityManagerFactoryBean entityManagerFactoryBean()
    {
        Map<String, Object> properties = new Hashtable<>();
        properties.put("javax.persistence.schema-generation.database.action",
                "none");
        properties.put("hibernate.connection.characterEncoding", "UTF-8");
        properties.put("hibernate.connection.useUnicode", "true");
        properties.put("hibernate.connection.characterSetResults", "UTF-8");

        HibernateJpaVendorAdapter adapter = new HibernateJpaVendorAdapter();
        adapter.setDatabasePlatform("org.hibernate.dialect.MySQL5InnoDBDialect");

        LocalContainerEntityManagerFactoryBean factory =
                new LocalContainerEntityManagerFactoryBean();
        factory.setJpaVendorAdapter(adapter);
        factory.setDataSource(this.lixiGlobalDataSource());
        factory.setPackagesToScan("vn.chonsoft.lixi.model");
        factory.setSharedCacheMode(SharedCacheMode.ENABLE_SELECTIVE);
        factory.setValidationMode(ValidationMode.NONE);
        factory.setJpaPropertyMap(properties);
        return factory;
    }

    @Bean
    public PlatformTransactionManager jpaTransactionManager()
    {
        return new JpaTransactionManager(
                this.entityManagerFactoryBean().getObject()
        );
    }

    @Bean
    public ThreadPoolTaskScheduler taskScheduler()
    {
        log.info("Setting up thread pool task scheduler with 20 threads.");
        ThreadPoolTaskScheduler scheduler = new ThreadPoolTaskScheduler();
        scheduler.setPoolSize(20);
        scheduler.setThreadNamePrefix("task-");
        scheduler.setAwaitTerminationSeconds(60);
        scheduler.setWaitForTasksToCompleteOnShutdown(true);
        scheduler.setErrorHandler(t -> schedulingLogger.error(
                "Unknown error occurred while executing task.", t
        ));
        scheduler.setRejectedExecutionHandler(
                (r, e) -> schedulingLogger.error(
                        "Execution of task {} was rejected for unknown reasons.", r
                )
        );
        return scheduler;
    }

    @Override
    public Executor getAsyncExecutor()
    {
        Executor executor = this.taskScheduler();
        log.info("Configuring asynchronous method executor {}.", executor);
        return executor;
    }

    @Override
    public void configureTasks(ScheduledTaskRegistrar registrar)
    {
        TaskScheduler scheduler = this.taskScheduler();
        log.info("Configuring scheduled method executor {}.", scheduler);
        registrar.setTaskScheduler(scheduler);
    }
    
    @Bean
    public JavaMailSenderImpl javaMailSender() {
        JavaMailSenderImpl mailSenderImpl = new JavaMailSenderImpl();
        mailSenderImpl.setHost(env.getProperty("smtp.host"));
        mailSenderImpl.setPort(env.getProperty("smtp.port", Integer.class));
        mailSenderImpl.setProtocol(env.getProperty("smtp.protocol"));
        mailSenderImpl.setUsername(env.getProperty("smtp.username"));
        mailSenderImpl.setPassword(env.getProperty("smtp.password"));
        mailSenderImpl.setDefaultEncoding("UTF-8");
        
        Properties javaMailProps = new Properties();
        javaMailProps.put("mail.smtp.auth", true);
        javaMailProps.put("mail.smtp.starttls.enable", true);
        javaMailProps.put("mail.debug", true);
        javaMailProps.put("mail.mime.charset", "UTF-8");

        mailSenderImpl.setJavaMailProperties(javaMailProps);

        return mailSenderImpl;
    }
    
    @Bean
    public VelocityEngine velocityEngine()throws VelocityException, IOException{
        
        VelocityEngineFactoryBean factory = new VelocityEngineFactoryBean();
        
        Properties velocityProperties = new Properties();
        velocityProperties.put("resource.loader", "class");
        velocityProperties.put("class.resource.loader.class", "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");
        velocityProperties.put("input.encoding", "UTF-8");
        velocityProperties.put("output.encoding", "UTF-8");
        velocityProperties.put("spring.velocity.properties.input.encoding", "UTF-8");
        velocityProperties.put("spring.velocity.properties.output.encoding", "UTF-8");
        
        factory.setVelocityProperties(velocityProperties);
        return factory.createVelocityEngine();
    }
    
    /**
     * 
     * @return
     * @throws Exception 
     */
    @Bean
    public LiXiSecurityManager securityManager() throws Exception{
        
        LiXiSecurityManager sm = new LiXiSecurityManager();
        sm.setPrivateKeyBytes(LiXiGlobalUtils.readKeyBytesFromFile(new ClassPathResource(env.getProperty("rsa.private_key_file")).getFile()));
        sm.setPublicKeyBytes(LiXiGlobalUtils.readKeyBytesFromFile(new ClassPathResource(env.getProperty("rsa.public_key_file")).getFile()));
        sm.initializeKeys();
        
        return sm;
    }
    
    /**
     * 
     * @return 
     */
    @Bean
    public TripleDES tripleDES(){
        TripleDES tripleDES = new TripleDES();
        tripleDES.setKey(env.getProperty("triple.des.key"));
        
        return tripleDES;
    }
    
    /**
     * 
     * @return 
     */
    @Bean
    public VtcPayClient vtcClient(){
    
        VtcPayClient vtcClient = new VtcPayClient();
        vtcClient.setDefaultUri("https://pay.vtc.vn/WS/GoodsPaygate.asmx?WSDL");//env.getProperty(?) ?
        vtcClient.setMarshaller(jaxb2Marshaller());
        vtcClient.setUnmarshaller(jaxb2Marshaller());
        //
        vtcClient.setVtcPartnerCode(env.getProperty("vtc.partner.code"));
        
        return vtcClient;
    }
    
    /**
     * 
     * @return 
     */
    @Bean
    public LixiAsyncMethods lxAsyncMethods(){
        
        return new LixiAsyncMethodsImpl();
    }
    
    /**
     * 
     * @return 
     */
    @Bean
    public CategoriesBean categoriesBean(){
        
        CategoriesBean c = new CategoriesBean();
        c.setCandies(this.lxCategoryService.findByCode(LiXiConstants.CAT_CANDIES));
        c.setJewelries(this.lxCategoryService.findByCode(LiXiConstants.CAT_JEWELRIES));
        c.setPerfume(this.lxCategoryService.findByCode(LiXiConstants.CAT_PERFUME));
        c.setCosmetics(this.lxCategoryService.findByCode(LiXiConstants.CAT_COSMETICS));
        c.setChildrentoy(this.lxCategoryService.findByCode(LiXiConstants.CAT_CHILDREN_TOY));
        c.setFlowers(this.lxCategoryService.findByCode(LiXiConstants.CAT_FLOWER));
        
        return c;
    }
}
