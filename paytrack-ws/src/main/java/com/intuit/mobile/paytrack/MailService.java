package com.intuit.mobile.paytrack;

import java.text.SimpleDateFormat;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

import com.intuit.mobile.paytrack.jaxb.Client;
import com.intuit.mobile.paytrack.jaxb.Provider;
import com.intuit.mobile.paytrack.jaxb.Receipt;

public class MailService {

	@Autowired
	private JavaMailSenderImpl mailSender;

	public void sendHTMLMail(String to, String subject, String htmlBody) {

		try {
			MimeMessage mimeMessage = mailSender.createMimeMessage();

			// use the true flag to indicate you need a multipart message
			MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
			helper.setTo(to);
			helper.setSubject(subject);

			// use the true flag to indicate the text included is HTML
			helper.setText(htmlBody, true);

			mailSender.send(mimeMessage);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public JavaMailSenderImpl getMailSender() {
		return mailSender;
	}

	public void setMailSender(JavaMailSenderImpl mailSender) {
		this.mailSender = mailSender;
	}

	public void sendEmail(Provider provider, Client client, Receipt receipt) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");

		String template = "<html>"
				+ "<body style='font-family: Arial; font-size: 14px;'>"
				+ "<table>"
				+ "<tr><th align='center'><h2>Receipt</h2></th></tr>"
				+ "<tr><th align='center'>&nbsp;</th></tr>"
				+ "<tr><th align='center'>&nbsp;</th></tr>"
				+ "<tr><td><b>Receipt No: "
				+ receipt.getId()
				+ "</b></td></tr>"
				+ "<tr><td><b>Date: "
				+ dateFormat.format(receipt.getDate())
				+ "</b></td></tr>"
				+ "<tr><th align='center'>&nbsp;</th></tr>"
				+ "<tr><th align='center'>&nbsp;</th></tr>"
				+ "<tr><td>Received sum of <b>Rs. "
				+ receipt.getAmount()
				+ "</b> from <b>"
				+ client.getFirstName()
				+ " "
				+ client.getLastName()
				+ "</b> towards <b>"
				+ provider.getServiceName()
				+ "</b> for the period starting from <b>"
				+ dateFormat.format(receipt.getFrom())
				+ "</b> to <b>"
				+ dateFormat.format(receipt.getTo())
				+ "</b></td></tr>"
				+ "<tr><th align='center'>&nbsp;</th></tr>"
				+ "<tr><th align='center'>&nbsp;</th></tr>"
				+ "<tr><td align='right'><b>Issued By</b></td></tr>"
				+ "<tr><td align='right'><b>"
				+ provider.getFirstName()
				+ " "
				+ provider.getLastName()
				+ "</b></td></tr>"
				+ "</table>"
				+ "</html>";
		
		sendHTMLMail(client.getEmail(), "Receipt for " + provider.getServiceName(), template);
	}

	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"beans.xml");
		MailService mailService = (MailService) context.getBean("mailService");
		mailService.sendHTMLMail("vijayan.srinivasan@gmail.com",
		"test subject", "test body");
	}

}