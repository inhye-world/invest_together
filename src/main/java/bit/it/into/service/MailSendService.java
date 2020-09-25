package bit.it.into.service;

import java.io.UnsupportedEncodingException;
import java.util.Random;
import javax.mail.MessagingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import bit.it.into.mail.MailUtils;

@Service()
public class MailSendService {
	
	private int size;
	
	 @Autowired
	 private JavaMailSenderImpl mailSender;

	    //인증키 생성
	    private String getKey(int size) {
	        this.size = size;
	        return getAuthCode();
	    }

	    //인증코드 난수 발생
	    private String getAuthCode() {
	        Random random = new Random();
	        StringBuffer buffer = new StringBuffer();
	        int num = 0;

	        while(buffer.length() < size) {
	            num = random.nextInt(10);
	            buffer.append(num);
	        }

	        return buffer.toString();
	    }

	    //회원가입시 인증메일 보내기
	    @Transactional
	    public String sendAuthMail(String email) {
	        //6자리 난수 인증번호 생성
	        String authKey = getKey(6);

	        //인증메일 보내기
	        try {
	            MailUtils sendMail = new MailUtils(mailSender);
	            sendMail.setSubject("회원가입 이메일 인증");
	            sendMail.setText(new StringBuffer().append("<h1>[이메일 인증]</h1>")
	            .append("<p>아래 링크를 클릭하시면 이메일 인증이 완료됩니다.</p>")
	            .append("<a href='http://localhost:8282/into/authConfirm?email=")
	            .append(email)
	            .append("&authKey=")
	            .append(authKey)
	            .append("' target='_blenk'>이메일 인증 확인</a>")
	            .toString());
	            sendMail.setFrom("hanrnj22@gmail.com", "같이투자");
	            sendMail.setTo(email);
	            sendMail.send();
	        } catch (MessagingException e) {
	            e.printStackTrace();
	        } catch (UnsupportedEncodingException e) {
	            e.printStackTrace();
	        }
	          return authKey;
	    }
	    
	    //비밀번호 찾을때 메일 전송
	    @Transactional
	    public String pwsendFindMail(String email) {
	        //6자리 난수 인증번호 생성
	        String authKey = getKey(6);

	        //인증메일 보내기
	        try {
	            MailUtils sendMail = new MailUtils(mailSender);
	            sendMail.setSubject("비밀번호 찾기 인증번호 전송");
	            sendMail.setText(new StringBuffer().append("<h1>[인증번호 안내]</h1>")
	            .append("<p>아래의 인증번호를 복사하신 후 이메일 인증번호 입력란에 입력해 주시기 바랍니다.</p>")
	            .append("인증번호 : " + authKey)
	            .toString());
	            sendMail.setFrom("hanrnj22@gmail.com", "같이투자");
	            sendMail.setTo(email);
	            sendMail.send();
	        } catch (MessagingException e) {
	            e.printStackTrace();
	        } catch (UnsupportedEncodingException e) {
	            e.printStackTrace();
	        }
	          return authKey;
	    }
	    
	    //아이디 찾을때 메일 전송
	    @Transactional
	    public String idsendFindMail(String email) {
	        //6자리 난수 인증번호 생성
	        String authKey = getKey(6);

	        //인증메일 보내기
	        try {
	            MailUtils sendMail = new MailUtils(mailSender);
	            sendMail.setSubject("아이디 찾기 인증번호 전송");
	            sendMail.setText(new StringBuffer().append("<h1>[인증번호 안내]</h1>")
	            .append("<p>아래의 인증번호를 복사하신 후 이메일 인증번호 입력란에 입력해 주시기 바랍니다.</p>")
	            .append("인증번호 : " + authKey)
	            .toString());
	            sendMail.setFrom("hanrnj22@gmail.com", "같이투자");
	            sendMail.setTo(email);
	            sendMail.send();
	        } catch (MessagingException e) {
	            e.printStackTrace();
	        } catch (UnsupportedEncodingException e) {
	            e.printStackTrace();
	        }
	          return authKey;
	    }
	    
}
