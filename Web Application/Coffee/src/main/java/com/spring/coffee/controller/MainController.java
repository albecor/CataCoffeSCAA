package com.spring.coffee.controller;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.coffee.model.Attribute;
import com.spring.coffee.model.Panel;
import com.spring.coffee.model.Role;
import com.spring.coffee.model.Sample;
import com.spring.coffee.model.Test;
import com.spring.coffee.model.Tests;
import com.spring.coffee.model.TestsId;
import com.spring.coffee.model.User;
import com.spring.coffee.service.AttributeService;
import com.spring.coffee.service.CustomerService;
import com.spring.coffee.service.EmailService;
import com.spring.coffee.service.PanelService;
import com.spring.coffee.service.PasswordResetTokenService;
import com.spring.coffee.service.RoleService;
import com.spring.coffee.service.SampleService;
import com.spring.coffee.service.TestService;
import com.spring.coffee.service.TestsService;
import com.spring.coffee.service.UserService;
import com.spring.coffee.utilities.Event4;

@Controller
@RequestMapping("/")
@SessionAttributes({ "officialRoles", "loggedinuser", "attributeslist" })
public class MainController {

	@Autowired
	CustomerService customerService;

	@Autowired
	TestsService testsService;

	@Autowired
	TestService testService;

	@Autowired
	SampleService sampleService;

	@Autowired
	UserService userService;

	@Autowired
	RoleService roleService;

	@Autowired
	PanelService panelService;

	@Autowired
	MessageSource messageSource;

	@Autowired
	AuthenticationTrustResolver authenticationTrustResolver;

	@Autowired
	AttributeService attributeService;

	@Autowired
	String IpServer;

	@Autowired
	PasswordResetTokenService passwordResetTokenService;

	@Autowired
	EmailService emailService;

	@Autowired
	PasswordEncoder passwordEncoder;

	boolean redirect_panel = false;

	/**
	 * This method will list all existing users.
	 */
	@RequestMapping(value = { "/" }, method = RequestMethod.GET)
	public String list(Model model) {

		if (!userService.existAdmin()) {
			Authentication auth = new UsernamePasswordAuthenticationToken(null, null,
					Arrays.asList(new SimpleGrantedAuthority("ROLE_TEMPORAL")));
			SecurityContextHolder.getContext().setAuthentication(auth);
			return "redirect:/te/new-admin";
		}

		if (isCurrentAuthenticationAnonymous()) {
			return "login";
		}

		for (GrantedAuthority grantedAuthority : getAuthorities()) {
			if (grantedAuthority.getAuthority().equals("ROLE_TEMPORAL")) {
				return "redirect:/te/new-admin";
			}

			if (grantedAuthority.getAuthority().equals("CHANGE_PASSWORD_PRIVILEGE")) {
				return "redirect:/logout";
			}
		}

		model.addAttribute("loggedinuser", getPrincipal());
		model.addAttribute("officialRoles", roleService.findAll());
		model.addAttribute("attributeslist", attributeService.findAll());
		model.addAttribute("user", new User());

		model.addAttribute("panels", panelService.authorizedByUserId(getPrincipal().getId()));
		return "index";
	}

	// ---------------CHANGE PASSWORD
	// ------------------------------------------------------------------

	/**
	 * 
	 * @param model
	 * @return resetPassword.jsp
	 */
	@RequestMapping(value = { "/re/resetPassword" }, method = RequestMethod.GET)
	public String resetPassword(Model model) {
		User user = new User();
		model.addAttribute("user", user);
		return "resetPassword";
	}

	/**
	 * post method to send email a new token to reset password
	 * 
	 * @param user
	 * @param result
	 * @param request
	 * @param response
	 * @param model
	 * @param redirectAttributes
	 * @param locale
	 * @return home (/)
	 */
	@RequestMapping(value = { "/re/resetPassword" }, method = RequestMethod.POST)
	public String resetPassword(@Valid User user, BindingResult result, HttpServletRequest request,
			HttpServletResponse response, Model model, RedirectAttributes redirectAttributes, Locale locale) {

		if (result.hasErrors()) {
			System.out.println(result.toString());
			return "resetPassword";
		}

		User entity = userService.selectByUsername(user.getUsername());
		if (entity == null) {

			FieldError ssoError = new FieldError("user", "username",
					messageSource.getMessage("error.notExistUser", new String[] { user.getUsername() }, locale));
			result.addError(ssoError);
			return "resetPassword";
		}

		passwordResetTokenService.deleteByUser(entity.getUsername());
		passwordResetTokenService.deleteExpiredPasswordResetToken();
		emailService.sendResetPasswordToken(getAppUrl(request), locale, entity);

		redirectAttributes.addFlashAttribute("notifyMesage", "reset-password-notify");
		redirectAttributes.addFlashAttribute("notifyType", "success");
		return "redirect:/";
	}

	/**
	 * show page to redirect user with credentials for change password
	 * 
	 * @param locale
	 * @param model
	 * @param id
	 * @param token
	 * @param redirectAttributes
	 * @return login.jsp
	 */
	@RequestMapping(value = "/re/changePassword", method = RequestMethod.GET)
	public String showChangePasswordPage(Locale locale, Model model, @RequestParam("id") Integer user_id,
			@RequestParam("token") String token, RedirectAttributes redirectAttributes) {

		String result = passwordResetTokenService.validatePasswordResetToken(user_id, token);

		if (result != null) {
			redirectAttributes.addFlashAttribute("notifyMesage", "expired-resetPasswordToken");
			redirectAttributes.addFlashAttribute("notifyType", "warning");
			return "redirect:/";
		}
		return "redirect:/ch/savePassword?lang=" + locale.getLanguage();
	}

	/**
	 * show form page to save the new password
	 * 
	 * @param model
	 * @return updatePassword.jsp
	 */

	@RequestMapping(value = { "/ch/savePassword" }, method = RequestMethod.GET)
	public String updatePassword(Model model) {
		User user = new User();
		model.addAttribute("user", user);
		return "forms/updatePassword";
	}

	/**
	 * post method to save the new password
	 * 
	 * @param user
	 * @param result
	 * @param request
	 * @param response
	 * @param model
	 * @param redirectAttributes
	 * @param locale
	 * @return login.jsp
	 */
	@RequestMapping(value = { "/ch/savePassword" }, method = RequestMethod.POST)
	public String updatePassword(@Valid User user, BindingResult result, HttpServletRequest request,
			HttpServletResponse response, Model model, RedirectAttributes redirectAttributes, Locale locale) {

		if (result.hasErrors()) {
			System.out.println(result.toString());
			return "forms/updatePassword";
		}

		User principal = getPrincipal();
		User entity = userService.selectByUsername(user.getUsername());
		FieldError ssoError = new FieldError("user", "username",
				messageSource.getMessage("error.document", new String[] {}, locale));

		if (entity == null) {
			result.addError(ssoError);
			return "forms/updatePassword";
		} else if (!entity.getUsername().equals(principal.getUsername())) {
			result.addError(ssoError);
			return "forms/updatePassword";
		}
		entity.setPassword(user.getPassword());
		userService.updateUser(entity);
		passwordResetTokenService.deleteByUser(entity.getUsername());
		redirectAttributes.addFlashAttribute("notifyMesage", "update-password-notify");
		redirectAttributes.addFlashAttribute("notifyType", "success");
		nullAuthentication(request, response);
		return "redirect:/login?logout";
	}

	/**
	 * to get the url where the server is located
	 * 
	 * @param request
	 * @return url server
	 */
	private String getAppUrl(HttpServletRequest request) {
		return "http://" + IpServer + ":" + request.getServerPort() + request.getContextPath();
	}

	// -------------- NEW SAMPLE
	// -------------------------------------------------------------------
	/**
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "/or/new-sample" }, method = RequestMethod.GET)
	public String newSample(Model model) {
		model.addAttribute("sample", new Sample());
		return "forms/sample";
	}

	@RequestMapping(value = "/or/new-sample", method = RequestMethod.POST)
	public String newSample(@Valid Sample sample, BindingResult result, Model model,
			RedirectAttributes redirectAttributes, Locale locale) {

		if (result.hasErrors()) {
			return "forms/sample";
		}

		Sample entity = sampleService.findByCode(sample.getCode());
		FieldError ssoError = new FieldError("sample", "code",
				messageSource.getMessage("error.code", new String[] {}, locale));

		if (entity != null) {
			result.addError(ssoError);
			return "forms/sample";
		}

		sampleService.save(sample);
		redirectAttributes.addFlashAttribute("notifyMesage", "notify.sample.created");
		redirectAttributes.addFlashAttribute("notifyType", "success");

		if (redirect_panel) {
			return "redirect:/or/new-panel";
		}
		return "redirect:/";
	}

	/**
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "/updateYourself" }, method = RequestMethod.GET)
	public String updateYourself(Model model) {
		User user = getPrincipal();
		user.setPassword("");
		model.addAttribute("user", user);

		return "forms/user";
	}

	// ------------------- UPDATE YOURSELF
	// ----------------------------------------------------------------------------
	@RequestMapping(value = { "/updateYourself" }, method = RequestMethod.POST)
	public String updateYourself(@Valid User user, BindingResult result, HttpServletRequest request,
			HttpServletResponse response, Model model, RedirectAttributes redirectAttributes, Locale locale) {

		if (result.hasErrors()) {
			System.out.println(result.toString());
			return "forms/user";
		}

		User entity = userService.selectByUsername(user.getUsername());
		if ((entity.getUsername() != null) && (entity.getId() != user.getId())) {

			FieldError ssoError = new FieldError("user", "username",
					messageSource.getMessage("notify.duplicateUser", new String[] { user.getUsername() }, locale));
			result.addError(ssoError);
			return "forms/user";
		}

		if (!checkAdmin(entity, user)) {
			FieldError ssoError = new FieldError("user", "roles",
					messageSource.getMessage("quit-admin-error-message", new String[] { user.getUsername() }, locale));
			result.addError(ssoError);
			return "forms/user";
		}

		userService.updateUser(user);
		redirectAttributes.addFlashAttribute("notifyMesage", "notify.updated-user-yourself");
		redirectAttributes.addFlashAttribute("notifyType", "success");
		nullAuthentication(request, response);
		return "redirect:/login?logout";
	}

	private boolean checkAdmin(User oldUser, User updateUser) {
		boolean oldUserIsAdmin = false;
		boolean updateUserIsAdmin = false;

		for (Role role : oldUser.getRoles()) {
			if (role.getId() == 2)
				oldUserIsAdmin = true;
		}

		for (Role role : updateUser.getRoles()) {
			if (role.getId() == 2)
				updateUserIsAdmin = true;
		}

		if (oldUserIsAdmin && !updateUserIsAdmin) {
			if (userService.countAdministrators() <= 1)
				return false;
		}

		return true;
	}

	// ---------------------- UPDATE USER BY ADMIN
	// ---------------------------------------------------

	/**
	 * 
	 * @param ndivalue
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/ad/update-user/{ndivalue}", method = RequestMethod.GET)
	public String updateUser(@PathVariable("ndivalue") String ndivalue, Model model) {

		if ((getPrincipal().getUsername()).equals(ndivalue)) {
			return "redirect:/updateYourself";
		}
		User user = userService.selectByUsername(ndivalue);
		user.setPassword("");

		model.addAttribute("user", user);
		return "forms/user";
	}

	/**
	 * 
	 * @param user
	 * @param result
	 * @param request
	 * @param response
	 * @param model
	 * @param redirectAttributes
	 * @param locale
	 * @return
	 */
	@RequestMapping(value = { "/ad/update-user" }, method = RequestMethod.POST)
	public String updateUser(@Valid User user, BindingResult result, HttpServletRequest request,
			HttpServletResponse response, Model model, RedirectAttributes redirectAttributes, Locale locale) {

		if (result.hasErrors()) {
			System.out.println(result.toString());
			return "redirect:/";
		}
		User entity = userService.selectByUsername(user.getUsername());
		if ((entity.getUsername() != null) && (entity.getId() != user.getId())) {
			FieldError ssoError = new FieldError("user", "username",
					messageSource.getMessage("notify.duplicateUser", new String[] { user.getUsername() }, locale));
			result.addError(ssoError);

			return "forms/user";
		}
		userService.updateUser(user);
		redirectAttributes.addFlashAttribute("notifyMesage", "notify.updated-user");
		redirectAttributes.addFlashAttribute("notifyType", "success");

		User loggedinuser = (User) request.getSession().getAttribute("loggedinuser");
		if (user.getId() == loggedinuser.getId()) {
			nullAuthentication(request, response);
			redirectAttributes.addFlashAttribute("notifyMesage", "notify.updated-user-yourself");
			return "redirect:/login?logout";

		}
		return "redirect:/";
	}

	/**
	 * 
	 * @param user
	 * @param result
	 * @param model
	 * @param redirectAttributes
	 * @param locale
	 * @return
	 */
	@RequestMapping(value = "/ad/consult-user", method = RequestMethod.POST)
	public String consultUser(@Valid User user, BindingResult result, Model model,
			RedirectAttributes redirectAttributes, Locale locale) {

		if (!userService.existUser(user.getUsername())) {

			redirectAttributes.addFlashAttribute("notifyMesage", "index.user.username.not-exist");
			redirectAttributes.addFlashAttribute("notifyType", "danger");

			return "redirect:/";
		}
		return "redirect:/ad/" + user.getUsername();
	}

	/**
	 * 
	 * @param ndivalue
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/or/update-sample-{id}", method = RequestMethod.GET)
	public String updateSample(@PathVariable("id") Integer id, Model model) {

		Sample sample = sampleService.findById(id);
		model.addAttribute("sample", sample);
		return "forms/sample";
	}

	/**
	 * 
	 * @param user
	 * @param result
	 * @param request
	 * @param response
	 * @param model
	 * @param redirectAttributes
	 * @param locale
	 * @return
	 */
	@RequestMapping(value = { "/or/update-sample" }, method = RequestMethod.POST)
	public String updateSample(@Valid Sample sample, BindingResult result, HttpServletRequest request,
			HttpServletResponse response, Model model, RedirectAttributes redirectAttributes, Locale locale) {

		if (result.hasErrors()) {
			System.out.println(result.toString());
			Sample samples = sampleService.findById(sample.getId());
			model.addAttribute("sample", samples);
			return "forms/sample";
		}

		Sample entity = sampleService.findByCode(sample.getCode());
		FieldError ssoError = new FieldError("sample", "code",
				messageSource.getMessage("error.code", new String[] {}, locale));

		if ((entity != null) && (entity.getId() != sample.getId())) {
			result.addError(ssoError);
			return "forms/sample";
		}

		entity = sampleService.findById(sample.getId());
		if (entity != null) {
			if (entity.getTest() != null) {
				sample.setTest(entity.getTest());
				sample.setDate(entity.getDate());
			}
		}
		sampleService.update(sample);
		redirectAttributes.addFlashAttribute("notifyMesage", "notify.updated-sample");
		redirectAttributes.addFlashAttribute("notifyType", "success");

		return "redirect:/or/samples";
	}

	/**
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/or/deleteSampleWithoutPanel-{id}", method = RequestMethod.GET)
	public String deleteSampleWithoutPanel(@PathVariable("id") Integer id, Model model) {

		sampleService.deleteSampleWithoutPanel(id);
		return "redirect:/or/new-panel";
	}

	/**
	 * 
	 * @param ndivalue
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/ad/{ndivalue}", method = RequestMethod.GET)
	public String consultUser(@PathVariable("ndivalue") String ndivalue, Model model) {
		User user = userService.selectByUsername(ndivalue);
		model.addAttribute("user", user);
		model.addAttribute("age", age(user.getBirthdate()));

		return "shows/user";
	}

	/**
	 * 
	 * @param birthdate
	 * @return
	 */
	private Integer age(String birthdate) {
		LocalDate today = LocalDate.now();
		LocalDate birthday = LocalDate.parse(birthdate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		Period p = Period.between(birthday, today);
		return p.getYears();
	}

	/**
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "/ad/new-user", "/or/new-user" }, method = RequestMethod.GET)
	public String newUser(Model model) {
		User user = new User();

		model.addAttribute("user", user);
		return "forms/user";
	}

	@RequestMapping(value = { "/or/update-test-notes" }, method = RequestMethod.POST)
	public String updateTestNotes(@Valid Test test, BindingResult result, HttpServletRequest request,
			HttpServletResponse response, Model model, Locale locale, RedirectAttributes redirectAttributes) {

		Test entity = testService.findById(test.getId());

		if (entity != null) {
			entity.setFragranceNotes(test.getFragranceNotes());
			entity.setFlavorNotes(test.getFlavorNotes());
			entity.setAcidityNotes(test.getAcidityNotes());
			entity.setBodyNotes(test.getBodyNotes());
			entity.setNotes(test.getNotes());
			testService.update(entity);
		}

		// redirectAttributes.addFlashAttribute("notifyMesage", "notify.created-user");
		// redirectAttributes.addFlashAttribute("notifyType", "success");
		return "redirect:/or/sample-" + sampleService.findByTestId(entity.getId()).getId();
	}

	/**
	 * 
	 * @param user
	 * @param result
	 * @param request
	 * @param response
	 * @param model
	 * @param locale
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = { "/ad/new-user", "/or/new-user" }, method = RequestMethod.POST)
	public String newUser(@Valid User user, BindingResult result, HttpServletRequest request,
			HttpServletResponse response, Model model, Locale locale, RedirectAttributes redirectAttributes) {

		if (result.hasErrors()) {
			return "forms/user";
		}
		if (userService.existUser(user.getUsername())) {
			FieldError ssoError = new FieldError("user", "username",
					messageSource.getMessage("notify.duplicateUser", new String[] { user.getUsername() }, locale));
			result.addError(ssoError);
			return "forms/user";
		}

		userService.saveUser(user);
		redirectAttributes.addFlashAttribute("notifyMesage", "notify.created-user");
		redirectAttributes.addFlashAttribute("notifyType", "success");
		return "redirect:/";
	}

	/**
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "/ad/list" }, method = RequestMethod.GET)
	public String listUsers(Model model) {

		List<User> users = userService.findAllUsers();
		model.addAttribute("users", users);
		return "userslist";
	}

	/**
	 * This method will provide the medium to add a new user.
	 */
	@RequestMapping(value = { "/or/panels" }, method = RequestMethod.GET)
	public String panels(Model model) {

		List<Panel> panels = panelService.unauthorized();

		model.addAttribute("panels", panels);

		return "shows/panels";
	}

	/**
	 * This method will provide the medium to add a new user.
	 */
	@RequestMapping(value = { "/or/samples" }, method = RequestMethod.GET)
	public String samples(Model model) {

		model.addAttribute("samples", sampleService.findAll());
		return "shows/samples";
	}

	private void setPanelModel(Model model) {

		List<User> tasters = userService.findUsersByRole("TASTER");
		model.addAttribute("tasters", tasters);

		List<Sample> samples = sampleService.selectSamplesWithoutPanel();
		model.addAttribute("samples", samples);

		if (samples.isEmpty() || tasters.isEmpty()) {
			model.addAttribute("disabledButton", true);
		}

	}

	/**
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "/or/new-panel" }, method = RequestMethod.GET)
	public String newtasty(Model model) {
		model.addAttribute("event", new Event4());
		setPanelModel(model);

		return "forms/panel";
	}

	@RequestMapping(value = { "/or/delete-sample-{id}" }, method = RequestMethod.GET)
	public String deleteSample(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {

		Sample sample = sampleService.findById(id);

		if (sample.getTest() != null) {
			if (sample.getTest().getFinished() == (byte) 1) {
				redirectAttributes.addFlashAttribute("notifyMesage", "notify.sample.finished");
				redirectAttributes.addFlashAttribute("notifyType", "danger");

			} else {
				redirectAttributes.addFlashAttribute("notifyMesage", "notify.sample.authorized");
				redirectAttributes.addFlashAttribute("notifyType", "danger");
			}

			return "redirect:/or/samples";
		}

		sampleService.delete(sample);
		redirectAttributes.addFlashAttribute("notifyMesage", "notify.sample.deleted");
		redirectAttributes.addFlashAttribute("notifyType", "success");

		return "redirect:/or/samples";
	}

	@RequestMapping(value = { "/or/authorize-panel-{id}" }, method = RequestMethod.GET)
	public String authorizePanel(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
		Panel panel = panelService.findById(id);

		panel.setAuthorizationDate(new Date());
		panelService.update(panel);

		redirectAttributes.addFlashAttribute("notifyMesage", "notify.panel.authorize");
		redirectAttributes.addFlashAttribute("notifyType", "success");
		return "redirect:/or/panels";
	}

	/**
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "/or/update-panel-{id}" }, method = RequestMethod.GET)
	public String newtasty(@PathVariable("id") Integer id, Model model) {

		Panel panel = panelService.findById(id);
		Event4 event = new Event4();

		Set<Integer> userId = new HashSet<>();
		Set<Integer> sampleId = new HashSet<>();
		Set<Sample> samplesPanel = new HashSet<>();

		for (Tests tests : panel.getTestses()) {
			userId.add(tests.getUser().getId());
			sampleId.add(tests.getSample().getId());
			event.setCups(tests.getTest().getCups());
			samplesPanel.add(tests.getSample());
		}

		event.setSampleId(new ArrayList<Integer>(sampleId));
		event.setTasterId(new ArrayList<Integer>(userId));

		// event.setSampleId(sampleId);
		model.addAttribute("event", event);
		List<User> tasters = userService.findUsersByRole("TASTER");
		model.addAttribute("tasters", tasters);

		List<Sample> samples = sampleService.selectSamplesWithoutPanel();
		samples.addAll(samplesPanel);

		model.addAttribute("samples", samples);
		model.addAttribute("panel", panel);

		if (samples.isEmpty() || tasters.isEmpty()) {
			model.addAttribute("disabledButton", true);
		}

		return "forms/panel";
	}

	@RequestMapping(value = { "/or/update-panel-{id}" }, method = RequestMethod.POST)
	public String updatePanel(@PathVariable("id") Integer id, @Valid Event4 event, BindingResult result,
			HttpServletRequest request, HttpServletResponse response, Model model,
			RedirectAttributes redirectAttributes, Locale locale) {

		Panel panel = panelService.findById(id);

		// Se eliminan todos los tests creados en el panel y el test para el
		// promedio en la muestra. La muestra no se elimina.
		for (Tests tests : panel.getTestses()) {
			Sample sample = sampleService.findById(tests.getSample().getId());
			sample.setTest(null);
			sampleService.update(sample);
			testsService.delete(tests);
		}

		List<Sample> samples = new ArrayList<>();

		for (Integer sampleId : event.getSampleId()) {
			samples.add(sampleService.findById(sampleId));
		}

		// este for crea el objeto test que sirve como resultado del promedio de
		// la prueba de los catadores para esta muestra
		for (Sample sample : samples) {
			Test test = new Test();
			test.setCups(event.getCups());
			testService.save(test);
			sample.setTest(test);
			sampleService.update(sample);

		}

		List<Integer> usersId = event.getTasterId();
		// este for crea el objecto tests para cada muestra en cada uno de los
		// catadores
		for (Integer userId : usersId) {
			for (Sample sample : samples) {
				Test test = new Test();
				test.setCups(event.getCups());
				testService.save(test);

				Tests tests = new Tests(new TestsId(test.getId(), sample.getId(), userId, panel.getId()));
				testsService.save(tests);
			}
		}

		redirectAttributes.addFlashAttribute("notifyMesage", "notify.panel.updated");
		redirectAttributes.addFlashAttribute("notifyType", "success");
		return "redirect:/or/panels";
	}

	@RequestMapping(value = { "/or/delete-panel-{id}" }, method = RequestMethod.GET)
	public String deletepanel(Model model, @PathVariable int id, RedirectAttributes redirectAttributes) {

		Panel panel = panelService.findById(id);

		// No se puede eliminar el panel si ya fue autorizado para una prueba de
		// catado
		if (panel.getAuthorizationDate() != null) {
			redirectAttributes.addFlashAttribute("notifyMesage", "notify.panel.no-delete.enabled");
			redirectAttributes.addFlashAttribute("notifyType", "danger");
			return "redirect:/";
		}

		// Se eliminan todos los tests creados en el panel y el test para el
		// promedio en la muestra. La muestra no se elimina.
		for (Tests tests : panel.getTestses()) {
			
			Sample sample = sampleService.findById(tests.getSample().getId());
			if(sample.getTest() != null) {
				Integer testId = sample.getTest().getId();			
				sample.setTest(null);			
				sampleService.update(sample);
				testService.deleteById(testId);
			}
			
			
			testsService.delete(tests);
			System.out.println(tests.getTest().getId());
			testService.deleteById(tests.getTest().getId());
		}
		panelService.delete(panel.getId());

		redirectAttributes.addFlashAttribute("notifyMesage", "notify.panel.deleted");
		redirectAttributes.addFlashAttribute("notifyType", "success");
		return "redirect:/or/panels";
	}

	/**
	 * 
	 * @param event
	 * @param result
	 * @param request
	 * @param response
	 * @param model
	 * @param redirectAttributes
	 * @param locale
	 * @return
	 */
	@RequestMapping(value = { "/or/new-panel" }, method = RequestMethod.POST)
	public String newtasty(@Valid Event4 event, BindingResult result, HttpServletRequest request,
			HttpServletResponse response, Model model, RedirectAttributes redirectAttributes, Locale locale) {

		if (event.getCups() == null) {

			model.addAttribute("notifyMesage", "alert.panel.cups.add");
			model.addAttribute("notifyType", "danger");
			model.addAttribute("cupsEmpty", true);
			model.addAttribute("event", new Event4());

			setPanelModel(model);
			return "forms/panel";
		}

		if (event.getTasterId().isEmpty()) {

			model.addAttribute("notifyMesage", "notify.taster.not-select");
			model.addAttribute("notifyType", "danger");
			model.addAttribute("emptyTaster", true);
			Event4 event2 = new Event4();
			event2.setCups(event.getCups());
			model.addAttribute("event", event2);
			setPanelModel(model);
			return "forms/panel";
		}

		Panel panel = new Panel();
		panelService.save(panel);

		List<Sample> samples = new ArrayList<>();

		for (Integer sampleId : event.getSampleId()) {
			samples.add(sampleService.findById(sampleId));
		}

		// este for crea el objeto test que sirve como resultado del promedio de
		// la prueba de los catadores para esta muestra
		for (Sample sample : samples) {
			Test test = new Test();
			test.setCups(event.getCups());
			testService.save(test);
			sample.setTest(test);
			sampleService.update(sample);

		}

		List<Integer> usersId = event.getTasterId();
		// este for crea el objecto tests para cada muestra en cada uno de los
		// catadores
		for (Integer userId : usersId) {
			for (Sample sample : samples) {
				Test test = new Test();
				test.setCups(event.getCups());
				testService.save(test);

				Tests tests = new Tests(new TestsId(test.getId(), sample.getId(), userId, panel.getId()));
				testsService.save(tests);
			}
		}

		redirectAttributes.addFlashAttribute("notifyMesage", "notify.panel.created");
		redirectAttributes.addFlashAttribute("notifyType", "success");
		return "redirect:/";
	}

	@RequestMapping(value = { "/test-{id}" }, method = RequestMethod.GET)
	public String test(Model model, @PathVariable int id) {

		Test test = testService.findById(id);
		model.addAttribute("test", test);
		return "forms/test";
	}

	@RequestMapping(value = { "/tas" }, method = RequestMethod.GET)
	public String testa(Model model) {

		return "/tabla";
	}

	@RequestMapping("/or/sampleReport-{sampleId}")
	public String verReporte(Model model, @PathVariable int sampleId,
			@RequestParam(name = "format", defaultValue = "pdf", required = false) String format) {

		model.addAttribute("format", format);

		Sample sample = sampleService.findById(sampleId);
		if (sample == null) {
			return "redirect:/";
		}

		model.addAttribute("datasource", sampleService.sampleReport(sample));
		return "sample21_report";
	}

	@RequestMapping(value = { "/or/disable-test-{testId}-{sampleId}-{disable}" }, method = RequestMethod.GET)
	public String editAverage(Model model, @PathVariable("sampleId") Integer sampleId,
			@PathVariable("testId") Integer testId, @PathVariable("disable") boolean disable,
			RedirectAttributes redirectAttributes) {

		Sample sample = sampleService.findById(sampleId);

		int countActive = 0;
		for (Tests tests : sample.getTestses()) {
			if (tests.getTest().getDisableScore() == (byte) 0) {
				countActive += 1;
			}
		}

		if (countActive <= 1 && disable == true) {
			redirectAttributes.addFlashAttribute("notifyMesage", "notify.taster.oneAtLeast");
			redirectAttributes.addFlashAttribute("notifyType", "danger");
			return "redirect:/or/sample-" + sampleId;
		}

		Test test = testService.findById(testId);

		if (disable) {
			test.setDisableScore((byte) 1);
		} else {
			test.setDisableScore((byte) 0);
		}

		testService.update(test);
		sample = sampleService.findById(sampleId);

		calculateAverage(sample.getId());

		return "redirect:/or/sample-" + sampleId;
	}

	@RequestMapping(value = { "/or/sample-{id}" }, method = RequestMethod.GET)
	public String sample(Model model, @PathVariable int id) {

		Sample sample = sampleService.findById(id);

		if (sample.getTest() != null) {

			int i = 0;
			for (Tests testses : sample.getTestses()) {
				if (testses.getTest().getDisableScore() == (byte) 1) {
					i += 1;
				}
			}
			i = sample.getTestses().size() - i;
			boolean onlyOne = false;
			if (i == 1) {
				onlyOne = true;
			}
			model.addAttribute("onlyOne", onlyOne);
		}

		// reviza si existe solamente una prueba activa para el promedio, si
		// solo existe una prueba activa entonces
		// la variable onlyOne se hace true, esto se usa para hacer la grafica
		// del promedio solo con la prueba activa y sin el promedio

		model.addAttribute("sample", sample);
		model.addAttribute("test", sample.getTest());

		return "shows/sample";
	}

	public void calculateAverage(Integer sampleId) {
		Sample sample = sampleService.findById(sampleId);
		float fragrance = 0;
		float aroma = 0;
		float flavor = 0;
		float aftertaste = 0;
		float acidity = 0;
		float body = 0;
		float uniformity = 0;
		float balance = 0;
		float cleanCup = 0;
		float sweetness = 0;
		float defect = 0;
		float tasterScore = 0;
		float totalScore = 0;
		float i = 0;
		Set<Attribute> atributos = new HashSet<>();
		for (Tests testses : sample.getTestses()) {

			if (testses.getTest().getDisableScore() == (byte) 0) {
				i += 1;
				fragrance += Float.parseFloat((testses.getTest().getFragrance()));
				aroma += Float.parseFloat((testses.getTest().getAroma()));
				flavor += Float.parseFloat((testses.getTest().getFlavor()));
				aftertaste += Float.parseFloat((testses.getTest().getResidualFlavor()));
				acidity += Float.parseFloat((testses.getTest().getAcidity()));
				body += Float.parseFloat((testses.getTest().getBody()));
				uniformity += Float.parseFloat((testses.getTest().getUniformity()));
				balance += Float.parseFloat((testses.getTest().getBalance()));
				cleanCup += Float.parseFloat((testses.getTest().getCleanCup()));
				sweetness += Float.parseFloat((testses.getTest().getSweetness()));
				defect += Float.parseFloat((testses.getTest().getDefect()));
				tasterScore += Float.parseFloat((testses.getTest().getTasterScore()));
				totalScore += Float.parseFloat((testses.getTest().getTotalScore()));
				atributos.addAll(testses.getTest().getAttributes());
			}
		}
		if (i != 0) {
			sample.getTest().setFragrance("" + fragrance / i);
			sample.getTest().setAroma("" + aroma / i);
			sample.getTest().setFlavor("" + flavor / i);
			sample.getTest().setResidualFlavor("" + aftertaste / i);
			sample.getTest().setAcidity("" + acidity / i);
			sample.getTest().setBody("" + body / i);
			sample.getTest().setUniformity("" + uniformity / i);
			sample.getTest().setBalance("" + balance / i);
			sample.getTest().setCleanCup("" + cleanCup / i);
			sample.getTest().setSweetness("" + sweetness / i);
			sample.getTest().setDefect("" + defect / i);
			sample.getTest().setTasterScore("" + tasterScore / i);
			sample.getTest().setTotalScore("" + totalScore / i);
			sample.getTest().setFinished((byte) 1);
			sample.getTest().setAttributes(atributos);

			testService.update(sample.getTest());
		}

	}

	public void finishPanel(Integer panel_id) {
		Panel panel = panelService.findById(panel_id);

		if (panel != null) {
			List<Sample> samplesByPanel = sampleService.samplesByPanel(panel_id);

			// revizamos cada prueba de cada muestra para finalizarlas
			for (Sample sample : samplesByPanel) {
				if (sample.getTest().getFinished() == (byte) 0) {
					boolean finishSample = true;
					// se evalua si las pruebas de la muestra fueron finalizadas
					for (Tests tests : sample.getTestses()) {
						if (tests.getTest().getFinished() == (byte) 0) {
							finishSample = false; // si al menos una no ha sido finalizada entonces finishSample se
													// coloca a false
						}
					}
					// si estan todas la prueba de las muestra terminadas entonces se procede a
					// promediar y finalizar la muestra.
					if (finishSample) {
						Sample samplefinished = sampleService.findById(sample.getId());
						samplefinished.setDate(new Date());
						sampleService.update(samplefinished);
						calculateAverage(sample.getId());
					}
				}
			}

			samplesByPanel = sampleService.samplesByPanel(panel_id); // actualizamos las muestras
			boolean finishPanel = true;
			for (Sample sample : samplesByPanel) {
				if (sample.getTest().getFinished() == (byte) 0) {
					finishPanel = false; // si alguna muestra no ha sido finalizada, el panel tampoco se finaliza
				}
			}

			// si todas las muestras del panel ya fueron finalizadas, se procede a finalizar
			// el panel.
			if (finishPanel) {
				panel.setRealizationDate(new Date());
				panel.setFinished((byte) 1);
				panelService.update(panel);
			}

		}

	}

	@RequestMapping(value = { "/ta/panel-test-{panel_id}" }, method = RequestMethod.GET)
	public String newtestPanel(@PathVariable("panel_id") Integer panel_id, Model model,
			RedirectAttributes redirectAttributes) {

		finishPanel(panel_id);
		List<Tests> testses = testsService.findStarted(getPrincipal().getId(), panel_id);

		if (testses.isEmpty()) {
			redirectAttributes.addFlashAttribute("notifyMesage", "notify.panel-finished");
			redirectAttributes.addFlashAttribute("notifyType", "success");

			return "redirect:/";
		}
		String url = null;
		for (Tests tests : testses) {
			url = "ta/panel-" + panel_id + "-test-" + tests.getTest().getId();
			break;
		}
		return "redirect:/" + url;
	}

	// este metodo agrega el atributo que en que se encuentra en ese momento la
	// prueba para cargar el mismo al cambiar de muestra
	@RequestMapping(value = { "/ta/paneli-{panel_id}-test-{test_id}-attr-{attr}" }, method = RequestMethod.GET)
	public String testAtr(@PathVariable("panel_id") Integer panel_id, @PathVariable("test_id") Integer test_id,
			@PathVariable("attr") String attr, Model model, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("attr", attr);
		return "redirect:/ta/panel-" + panel_id + "-test-" + test_id;
	}

	@RequestMapping(value = { "/ta/panel-{panel_id}-test-{test_id}" }, method = RequestMethod.GET)
	public String newtest(@PathVariable("panel_id") Integer panel_id, @PathVariable("test_id") Integer test_id,
			Model model) {

		List<Tests> testses = testsService.findStarted(getPrincipal().getId(), panel_id);
		model.addAttribute("testses", testses);
		for (Tests tests : testses) {
		
			if (tests.getTest().getId().equals(test_id) ) {
				
				model.addAttribute("test", tests.getTest());
				// System.out.println(new Gson().toJson(tests.getTest().getAttributes()));
				model.addAttribute("sample", tests.getSample());
				model.addAttribute("panelId", tests.getId().getPanelId());
				break;
			}
		}

		return "forms/test";
	}

	@RequestMapping(value = { "/test" }, method = RequestMethod.POST)
	public String test(Test test, BindingResult result, Model model) {

		if (result.hasErrors()) {
			model.addAttribute("test", test);
			return "forms/test";
		}

		System.out.println(test.getFragrance() + "---------------");
		System.out.println(test.getId() + "---------------");

		/*
		 * test.setFinished((byte) 1); testService.update(test);
		 * 
		 * Integer sample = testsService.findByTest(test.getId()).getId().getSampleId();
		 * 
		 * if (testsService.TestFinalizedBySample(sample)) {
		 * 
		 * List<Tests> tests = testsService.findTestBySample(sample);
		 * 
		 * String notes = ""; BigDecimal acidity = new BigDecimal(0); BigDecimal aroma =
		 * new BigDecimal(0); BigDecimal balance = new BigDecimal(0); BigDecimal body =
		 * new BigDecimal(0); BigDecimal cleanCup = new BigDecimal(0); BigDecimal defect
		 * = new BigDecimal(0); BigDecimal flavor = new BigDecimal(0); BigDecimal
		 * fragrance = new BigDecimal(0); BigDecimal residualFlavor = new BigDecimal(0);
		 * BigDecimal sweetness = new BigDecimal(0); BigDecimal tasterScore = new
		 * BigDecimal(0); BigDecimal uniformity = new BigDecimal(0); BigDecimal
		 * totalScore = new BigDecimal(0); BigDecimal i = new BigDecimal(0);
		 * Set<Attribute> attributes = new HashSet<Attribute>(0);
		 * 
		 * for (Tests item : tests) {
		 * 
		 * acidity = acidity.add(item.getTest().getAcidity()); balance =
		 * balance.add(item.getTest().getBalance()); body =
		 * body.add(item.getTest().getBody()); cleanCup =
		 * cleanCup.add(item.getTest().getCleanCup()); defect =
		 * defect.add(item.getTest().getDefect()); flavor =
		 * flavor.add(item.getTest().getFlavor()); residualFlavor =
		 * residualFlavor.add(item.getTest().getResidualFlavor()); sweetness =
		 * sweetness.add(item.getTest().getSweetness()); tasterScore =
		 * tasterScore.add(item.getTest().getTasterScore()); uniformity =
		 * uniformity.add(item.getTest().getUniformity()); fragrance =
		 * fragrance.add(item.getTest().getFragrance()); aroma =
		 * aroma.add(item.getTest().getAroma());
		 * 
		 * i = i.add(new BigDecimal(1));
		 * 
		 * notes = notes + ". " + item.getTest().getNotes();
		 * 
		 * attributes.removeAll(item.getTest().getAttributes());
		 * attributes.addAll(item.getTest().getAttributes()); }
		 * 
		 * totalScore = totalScore.add(acidity).add(aroma.divide(new
		 * BigDecimal(2))).add(balance).add(body)
		 * .add(cleanCup).subtract(defect).add(flavor).add(fragrance.divide(new
		 * BigDecimal(2)))
		 * .add(residualFlavor).add(sweetness).add(tasterScore).add(uniformity);
		 * 
		 * Sample sample2 = sampleService.findById(sample); sample2.setFinished((byte)
		 * 1); sampleService.update(sample2);
		 * 
		 * int scale = 3; sample2.getTest().setAcidity(acidity.divide(i, scale,
		 * RoundingMode.HALF_UP)); sample2.getTest().setAroma(aroma.divide(i, scale,
		 * RoundingMode.HALF_UP)); sample2.getTest().setBalance(balance.divide(i, scale,
		 * RoundingMode.HALF_UP)); sample2.getTest().setBody(body.divide(i, scale,
		 * RoundingMode.HALF_UP)); sample2.getTest().setCleanCup(cleanCup.divide(i,
		 * scale, RoundingMode.HALF_UP)); sample2.getTest().setDefect(defect.divide(i,
		 * scale, RoundingMode.HALF_UP)); sample2.getTest().setFlavor(flavor.divide(i,
		 * scale, RoundingMode.HALF_UP)); sample2.getTest().setDefect(defect.divide(i,
		 * scale, RoundingMode.HALF_UP));
		 * sample2.getTest().setFragrance(fragrance.divide(i, scale,
		 * RoundingMode.HALF_UP));
		 * sample2.getTest().setResidualFlavor(residualFlavor.divide(i, scale,
		 * RoundingMode.HALF_UP)); sample2.getTest().setSweetness(sweetness.divide(i,
		 * scale, RoundingMode.HALF_UP));
		 * sample2.getTest().setTasterScore(tasterScore.divide(i, scale,
		 * RoundingMode.HALF_UP)); sample2.getTest().setUniformity(uniformity.divide(i,
		 * scale, RoundingMode.HALF_UP));
		 * sample2.getTest().setTotalScore(totalScore.divide(i, scale,
		 * RoundingMode.HALF_UP)); sample2.getTest().setAttributes(attributes);
		 * sample2.getTest().setNotes(notes); sample2.getTest().setFinished((byte) 1);
		 * 
		 * testService.update(sample2.getTest()); }
		 */
		return "redirect:/or/panel-test-" + 1;
	}

	/**
	 * show page to delete user
	 * 
	 * @param ndivalue
	 * @param model
	 * @param redirectAttributes
	 * @return forms/deleteUser.jsp
	 */
	@RequestMapping(value = "/ad/delete-user-{username}", method = RequestMethod.GET)
	public String deleteUser(@PathVariable("username") String username, Model model,
			RedirectAttributes redirectAttributes) {

		User user = userService.selectByUsername(username);
		passwordResetTokenService.deleteByUser(user.getUsername());

		for (Role role : user.getRoles()) {
			if (role.getType().equals("ADMIN")) {
				redirectAttributes.addFlashAttribute("notifyMesage", "notify.not-delete-user-admin");
				redirectAttributes.addFlashAttribute("notifyType", "danger");
				return "redirect:/";
			}
		}

		List<Tests> tests = testsService.findStartedByUser(user.getId());

		if (!tests.isEmpty()) {
			redirectAttributes.addFlashAttribute("notifyMesage", "notify.not-delete-user-cupping");
			redirectAttributes.addFlashAttribute("notifyType", "danger");
			return "redirect:/";
		}

		model.addAttribute("user", user);
		model.addAttribute("userPrincipal", new User());
		return "forms/deleteUser";
	}

	/**
	 * post method to delete user
	 * 
	 * @param userPrincipal
	 * @param ndivalue
	 * @param result
	 * @param request
	 * @param response
	 * @param model
	 * @param redirectAttributes
	 * @param locale
	 * @return redirect to home (/)
	 */
	@RequestMapping(value = { "/ad/delete-user-{usernameDelete}" }, method = RequestMethod.POST)
	public String deleteUser(@ModelAttribute("userPrincipal") User userPrincipal,
			@PathVariable("usernameDelete") String usernameDelete, BindingResult result, HttpServletRequest request,
			HttpServletResponse response, Model model, RedirectAttributes redirectAttributes, Locale locale) {

		if (result.hasErrors()) {
			System.out.println(result.toString());
			return "redirect:/";
		}

		User principal = getPrincipal();

		if (!passwordEncoder.matches(userPrincipal.getPassword(), principal.getPassword())) {
			FieldError ssoError = new FieldError("userPrincipal", "password",
					messageSource.getMessage("incorrect-password", new String[] {}, locale));
			result.addError(ssoError);
			User user = userService.selectByUsername(usernameDelete);

			model.addAttribute("user", user);
			
			return "forms/deleteUser";
		}

		if (!(principal.getUsername().equals(userPrincipal.getUsername()))) {
			FieldError ssoError = new FieldError("userPrincipal", "username",
					messageSource.getMessage("incorrect-document", new String[] {}, locale));
			result.addError(ssoError);
			User user = userService.selectByUsername(usernameDelete);

			model.addAttribute("user", user);
		
			return "forms/deleteUser";
		}

		User user = userService.selectByUsername(usernameDelete);

		// delete user
		userService.deleteUserById(user.getId());

		redirectAttributes.addFlashAttribute("notifyMesage", "notify.user-deleted");
		redirectAttributes.addFlashAttribute("notifyType", "success");
		return "redirect:/";
	}

	// ***************** new admin*******************

	@RequestMapping(value = "/te/new-admin", method = RequestMethod.GET)
	public String newAdmin(Model model) {

		User user = new User();

		model.addAttribute("user", user);
		return "forms/user";
	}

	@RequestMapping(value = { "/te/new-admin" }, method = RequestMethod.POST)
	public String newAdmin(@Valid User user, BindingResult result, HttpServletRequest request,
			HttpServletResponse response, Model model, Locale locale, RedirectAttributes redirectAttributes) {

		if (result.hasErrors()) {
			return "forms/user";
		}
		userService.saveUser(user);
		redirectAttributes.addFlashAttribute("notifyMesage", "login.msg.temporal");
		redirectAttributes.addFlashAttribute("notifyType", "success");
		nullAuthentication(request, response);
		return "redirect:/login?logout";
	}

	@RequestMapping(value = "/Access_Denied", method = RequestMethod.GET)
	public String accessDeniedPage(Model model) {
		return "accessDenied";
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout, HttpServletRequest request, Model model) {
		if (isCurrentAuthenticationAnonymous()) {
			return "login";
		}
		return "redirect:/";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logoutPage(HttpServletRequest request, HttpServletResponse response) {
		nullAuthentication(request, response);
		return "redirect:/login?logout";
	}

	private void nullAuthentication(HttpServletRequest request, HttpServletResponse response) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			try {
				request.logout();
			} catch (ServletException e) {

				e.printStackTrace();
			}
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
	}

	/**
	 * This method returns the principal[user-name] of logged-in user.
	 */
	private User getPrincipal() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (principal instanceof User)
			return (User) principal;
		else if (principal instanceof UserDetails)
			return userService.selectByUsername(((UserDetails) principal).getUsername());
		else
			return new User();
	}

	/**
	 * This method returns true if users is already authenticated [logged-in], else
	 * false.
	 */
	private boolean isCurrentAuthenticationAnonymous() {
		final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		return authenticationTrustResolver.isAnonymous(authentication);
	}

	private Collection<? extends GrantedAuthority> getAuthorities() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		return authentication.getAuthorities();
	}
}