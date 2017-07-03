package com.fairmusic.loginEmailauth;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
 
public class MailSenderEx01 {
    
    private String fromEmail = "fairmusichelp@gmail.com"; // 보내는 사람 이메일(gmail) 아이디
    private String password = "fairmusic"; // 보내는 사람 이메일(gmail) 비밀번호
    
    public static void main(String[] args) {
        // TODO Auto-generated method stub
    	MailSenderEx01 mail = new MailSenderEx01();
    	
    	String authNum = mail.RandomNum();
    	String toEmail = "junie2368@naver.com"; // 받는 사람 이메일 주소
        String toName = "한준희 회원님";
        String subject = "FairMusic 이메일 인증입니다.";
        String content = "인증번호 ["+authNum+"]";
        
        mail.sendMail(toEmail, toName, subject, content);
    }
    
    // 받는 사람 이메일, 보내는 사람 이름, 메일 제목, 메일 내용
    public void sendMail(String toEmail, String toName, String subject, String content) {
        try {
            // 보내는 사람(gmail)의 환경 설정 부분으로 이 부분이 가장 중요하다.
            Properties props = new Properties();
 
            // 접속 환경 설정
            // 아래의 환경 설정은 구글에서 이렇게 쓰라고 주는 것
            props.put("mail.smtp.starttls", "true");
            props.put("mail.transport.protocol", "smtp");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.port", "465");
            props.put("mail.smtp.auth", "true");
            
            // 인증 환경 설정
            Session sess = Session.getDefaultInstance(props,new javax.mail.Authenticator(){
				protected PasswordAuthentication getPasswordAuthentication() {
			        return new PasswordAuthentication(fromEmail, password);
			    }
			});
            
            // 메세지 내용 처리
            MimeMessage msg = new MimeMessage(sess);
            msg.setHeader("content-type", "text/plain;charset=utf-8");
            
            // 보낼 사람
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail, toName, "utf-8"));
            
            // 보낼 제목
            msg.setSubject(subject);
            
            // 보낼 내용
            // 이 부분을 html과 plain에 따라서 문서 타입이 바뀐다.
            msg.setContent(content, "text/html;charset=utf-8");
            msg.setSentDate(new java.util.Date());
            
            Transport.send(msg);
            
            System.out.println("전송이 완료되었습니다.");
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (MessagingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    public String RandomNum(){
    	StringBuffer buffer = new StringBuffer();
    	for (int i = 0; i <= 6; i++) {
			int n = (int)(Math.random()*10);
			buffer.append(n);
		}
    	return buffer.toString();
    }
 
}
