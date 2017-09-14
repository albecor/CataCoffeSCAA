package com.spring.coffee.service;

import java.util.Date;
import java.util.Locale;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.coffee.model.PasswordResetToken;
import com.spring.coffee.model.User;

@Service("emailService")
@Transactional
public class EmailServiceImpl implements EmailService {

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	MessageSource messageSource;

	@Autowired
	UserService userService;

	@Autowired
	PasswordResetTokenService passwordResetTokenService;

	@Override
	@Async
	public void sendSimpleMessage(String to, String subject, String text) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(to);
		message.setSubject(subject);
		message.setText(text);
		mailSender.send(message);

	}

	@Override
	public void sendResetPasswordToken(String contextPath, Locale locale, User user) {
		String token = UUID.randomUUID().toString();
		String url = contextPath + "/re/changePassword?id=" + user.getId() + "&token=" + token;
		String subject = messageSource.getMessage("subject.reset-password", new String[] {}, locale);
		String message = messageSource.getMessage("body.reset-password",
				new String[] { user.getFirstName() + " " + user.getLastName(), url }, locale);

		sendMimeMessage(user.getEmail(), subject, message);

		PasswordResetToken passwordResetToken = new PasswordResetToken();
		passwordResetToken.setDate(new Date());
		passwordResetToken.setToken(token);
		passwordResetToken.setUser(user);
		passwordResetTokenService.insert(passwordResetToken);
		;
	}

	@Override
	public void sendMimeMessage(String to, String subject, String text) {

		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message);
		try {
			helper.setTo(to);
			helper.setSubject(subject);
			helper.setText(text, true);

		} catch (MessagingException e) {
			e.printStackTrace();
		}
		mailSender.send(message);
	}

}
