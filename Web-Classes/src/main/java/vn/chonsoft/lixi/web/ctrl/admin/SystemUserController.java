/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.AdminUser;
import vn.chonsoft.lixi.model.AdminUserAuthority;
import vn.chonsoft.lixi.model.Authority;
import vn.chonsoft.lixi.model.form.AdminUserAddForm;
import vn.chonsoft.lixi.model.form.AdminUserEditForm;
import vn.chonsoft.lixi.repositories.service.AdminUserAuthorityService;
import vn.chonsoft.lixi.repositories.service.AdminUserService;
import vn.chonsoft.lixi.repositories.service.AuthorityService;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping(value = "/Administration/SystemUser")
@PreAuthorize("hasAuthority('SYSTEM_USER_CONTROLLER')")
public class SystemUserController {

    // log
    private static final Logger log = LogManager.getLogger(SystemUserController.class);

    @Inject
    AdminUserService adminUserService;

    @Inject
    AdminUserAuthorityService auAuService;

    @Inject
    AuthorityService authService;

    /**
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ModelAndView list(Map<String, Object> model) {

        model.put("ADMIN_USER_LIST", this.adminUserService.findAll());

        return new ModelAndView("Administration/user/list");
    }

    /**
     *
     * @param userId
     * @param enable
     * @return
     */
    @RequestMapping(value = "enable/{userId}/{enable}", method = RequestMethod.GET)
    public View enable(@PathVariable long userId, @PathVariable int enable) {

        AdminUser au = this.adminUserService.find(userId);

        au.setEnabled(0 == enable ? false : true);

        this.adminUserService.save(au);

        return new RedirectView("/Administration/SystemUser/list", true, true);
    }

    /**
     *
     * @param model
     * @param userId
     * @return
     */
    @RequestMapping(value = "detail/{userId}", method = RequestMethod.GET)
    public ModelAndView detail(Map<String, Object> model, @PathVariable long userId) {

        AdminUser au = this.adminUserService.find(userId);
        List<Authority> authorities = this.authService.findByParentId(0L);
        // checked
        for (Authority auth : authorities) {

            for (AdminUserAuthority auAuth : au.getAuthorities()) {
                if (auth.getAuthority().equals(auAuth.getAuthority())) {

                    auth.setChecked(Boolean.TRUE);
                    break;

                }
            }
            // for children
            List<Authority> children = this.authService.findByParentId(auth.getId());
            for (Authority child : children) {
                for (AdminUserAuthority auAuth : au.getAuthorities()) {
                    if (child.getAuthority().equals(auAuth.getAuthority())) {
                        child.setChecked(Boolean.TRUE);
                        break;

                    }
                }
            }
            auth.setChildren(children);
        }

        model.put("adminUserEditForm", new AdminUserEditForm(au));

        model.put("AUTHORITIES", authorities);

        return new ModelAndView("Administration/user/detail");
    }

    /**
     *
     * @param model
     * @param form
     * @param errors
     * @return
     */
    @RequestMapping(value = "detail/{userId}", method = RequestMethod.POST)
    public ModelAndView detail(Map<String, Object> model,
            @Valid AdminUserEditForm form, Errors errors) {

        if (errors.hasErrors()) {

            return new ModelAndView("Administration/user/detail");

        }

        try {

            AdminUser au = this.adminUserService.find(form.getId());
            au.setFirstName(form.getFirstName());
            au.setMiddleName(form.getMiddleName());
            au.setLastName(form.getLastName());
            au.setEmail(form.getEmail());
            au.setPhone(form.getPhone());
            au.setEnabled(form.isEnabled());
            au.setPasswordNextTime(form.isChangePasswordNextTime());
            log.info("password net time: " + form.isChangePasswordNextTime());
            //set modified
            au.setModifiedDate(Calendar.getInstance().getTime());
            au.setModifiedBy(SecurityContextHolder.getContext().getAuthentication().getName());

            this.adminUserService.save(au);

        } catch (ConstraintViolationException e) {
            //
            log.info(e.getMessage(), e);
            //
            model.put("validationErrors", e.getConstraintViolations());
        }

        //model.put("editAdminUserForm", new AdminUserEditForm(this.adminUserService.find(form.getId())));
        return new ModelAndView(new RedirectView("/Administration/SystemUser/detail/" + form.getId(), true, true));

    }

    /**
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "roles", method = RequestMethod.POST)
    public ModelAndView roles(HttpServletRequest request) {

        String[] roles = request.getParameterValues("roles");

        Long id = Long.parseLong(request.getParameter("id"));
        AdminUser au = this.adminUserService.find(id);
        // delete roles
        this.auAuService.deleteByAdminUserId(id);

        // insert roles
        for (String role : Arrays.asList(roles)) {

            this.auAuService.save(new AdminUserAuthority(id, role, au));

        }

        // return back edit form
        return new ModelAndView(new RedirectView("/Administration/SystemUser/detail/" + id, true, true));
    }

    /**
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "add", method = RequestMethod.GET)
    public ModelAndView add(Map<String, Object> model) {

        List<Authority> authorities = this.authService.findAll();

        model.put("adminUserAddForm", new AdminUserAddForm());
        model.put("AUTHORITIES", authorities);

        return new ModelAndView("Administration/user/add");
    }

    /**
     *
     * @param model
     * @param form
     * @param errors
     * @return
     */
    @RequestMapping(value = "add", method = RequestMethod.POST)
    public ModelAndView add(Map<String, Object> model,
            @Valid AdminUserAddForm form, Errors errors) {

        if (errors.hasErrors()) {

            model.put("AUTHORITIES", this.authService.findAll());
            return new ModelAndView("Administration/user/add");

        }

        try {

            AdminUser au = new AdminUser();
            au.setFirstName(form.getFirstName());
            au.setMiddleName(form.getMiddleName());
            au.setLastName(form.getLastName());
            au.setEmail(form.getEmail());
            au.setPhone(form.getPhone());
            au.setPassword((new BCryptPasswordEncoder()).encode(form.getPassword()));
            au.setEnabled(form.isEnabled());
            au.setPasswordNextTime(form.isChangePasswordNextTime());
            // default
            au.setAccountNonExpired(true);
            au.setAccountNonLocked(true);
            au.setCredentialsNonExpired(true);
            //
            au.setCreatedBy(SecurityContextHolder.getContext().getAuthentication().getName());
            au.setCreatedDate(Calendar.getInstance().getTime());

            // save to get ID
            this.adminUserService.save(au);

            log.info("new id : " + au.getId());
            //
            List<AdminUserAuthority> authorities = new ArrayList<>();
            for (String authority : form.getAuthorities()) {

                authorities.add(new AdminUserAuthority(authority, au));
            }

            this.auAuService.save(authorities);

            // update
            this.adminUserService.save(au);

        } catch (ConstraintViolationException e) {
            //
            log.info(e.getMessage(), e);
            //
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("Administration/user/add");
        }

        return new ModelAndView(new RedirectView("/Administration/SystemUser/list", true, true));
    }
}
