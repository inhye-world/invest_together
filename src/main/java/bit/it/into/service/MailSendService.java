package bit.it.into.service;

import java.io.UnsupportedEncodingException;
import java.util.Random;
import javax.mail.MessagingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import bit.it.into.mail.MailUtils;

@Service
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

	        String htmlText = "<HTML>" +
	        	     "<HEAD></HEAD>" +
	        	     "<BODY>" +
	        	     "<table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" style=\"background: #f0f4f6;\">" +
	    			 "<tbody>" +
	        	     "<tr>" +
	    			 "<td>" +
	        	     "<div style=\"width: 712px; margin: 0 auto\">" +
	    			 "<table cellspacing=\"0\" cellpadding=\"0\" width=\"712\">" +
	        	     "<tbody>" +
	    			 "<tr text-align: center;>" +
	        	     "<td style=\"padding-top: 56px; padding-bottom: 22px; padding-left: 16px; text-align: center;\">" +
	        	     "<img src=\"http://localhost:8282/into/resources/main/assets/img/logo/logo.png\"></img>"+ 
	    			 "</td>" +
	        	     "</tr>" +
	    			 "<tr>" +
	        	     "<td style=\"vertical-align: top;\">" +
	        	     "<table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\">" +
	        	     "<tbody>" +
	        	     "<tr>" +
	        	     "<td style=\"vertical-align: top\">" +
	        	     "<img src=\"https://www.ssafy.com/swp/images/edm/bg_left.png\" alt=\"\" style=\"vertical-align: top\" loading=\"lazy\">" +  
	        	     "</td>" +
	        	     "<td style=\"vertical-align: top; padding-top: 68px; width:680px; background: #fff\">" +
	        	     "<table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\">" +
	        	     "<tbody>" +
	        	     "<tr>" +
	        	     "<td style=\"font-family: '맑은 고딕', 'malgun gothic', 돋움, dotum, sans-serif; font-size: 24px; color:#000000; text-align: center\">" +
	        	     "이메일 수신 확인" +
	        	     "</td>" +
	        	     "</tr>" +
	        	     "<tr>" +
	        	     "<td style=\"text-align: center; line-height: 0; padding-top: 25px; padding-bottom: 25px;\">" +
	        	     "<img src=\"https://www.ssafy.com/swp/images/edm/bar.gif\" alt=\"\" style=\"vertical-align: top\" loading=\"lazy\">" +
	        	     "</td>" +
	        	     "</tr>" +
	        	     "<tr>" +
	        	     "<td style=\"font-family: '맑은 고딕', 'malgun gothic', 돋움, dotum, sans-serif; font-size: 18px; mso-line-height-rule: exactly; line-height: 26px; color: #6e7c8c; text-align: center\">" +
	        	     "<br>" +
	        	     "메일주소 확인을 위해 발송된 메일 입니다." +
	        	     "<br>" +
	        	     "아래 " +
	        	     "<span style=\"color:#3c90e2\">회원등록 확인 버튼</span>" +
	        	     "을 클릭하여 회원등록 절차를" +
	        	     "<br>" +
	        	     "완료해주시기 바랍니다" +
	        	     "</td>" +
	        	     "</tr>" +
	        	     "<tr>" +
	        	     "<td style=\"text-align: center; padding-top: 28px; padding-bottom: 80px\">" +
	        	     "<a href='http://localhost:8282/into/authConfirm?email=" + email + "' target='_blenk' style=\"border: 0\" rel=\"noreferrer noopener\"><img src=\"https://www.ssafy.com/swp/images/edm/btn-1.gif\" alt=\"회원등록 확인\" style=\"border: 0\" loading=\"lazy\"></a>" + 
	        	     "</td>" +
	        	     "</tr>" +   
	        	     "</tbody>" +
	        	     "</table>" +
	        	     "</td>" +
	        	     "<td style=\"vertical-align: top\">" +
	        	     "<img src=\"https://www.ssafy.com/swp/images/edm/bg_right.png\" alt=\"\" style=\"vertical-align: top\" loading=\"lazy\">" +
	        	     "</td>" +
	        	     "</tr>" +
	        	     "</tbody>" +
	        	     "</table>" +
	    			 "</td>" +    	     
	        	     "</tr>" +
	    			 "<tr>" +
	        	     "<td height=\"28\" style=\"vertical-align: top\">" +
	    			 "<img src=\"https://www.ssafy.com/swp/images/edm/bg_btm.png\" alt=\"\" style=\"vertical-align: top;\" loading=\"lazy\">" +
	    			 "</td>" +
	        	     "</tr>" +
	    			 "</tbody>" +     
	        	     "</table>" +
	    			 "</div>" +
	        	     "</td>" +
	    			 "</tr>" +
	        	     "</tbody>" +
	        	     "</table>" +
	        	     "</BODY>" +
	        	     "</HTML>";
	        
	        //인증메일 보내기
	        try {
	            MailUtils sendMail = new MailUtils(mailSender);
	            sendMail.setSubject("회원가입 이메일 인증");
	            sendMail.setText(htmlText);
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
	        
	        String htmlText = "<HTML>" +
	        	     "<HEAD></HEAD>" +
	        	     "<BODY>" +
	        	     "<table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" style=\"background: #f0f4f6;\">" +
	    			 "<tbody>" +
	        	     "<tr>" +
	    			 "<td>" +
	        	     "<div style=\"width: 712px; margin: 0 auto\">" +
	    			 "<table cellspacing=\"0\" cellpadding=\"0\" width=\"712\">" +
	        	     "<tbody>" +
	    			 "<tr text-align: center;>" +
	        	     "<td style=\"padding-top: 56px; padding-bottom: 22px; padding-left: 16px; text-align: center;\">" +
	        	     "<img src=\"http://localhost:8282/into/resources/main/assets/img/logo/logo.png\"></img>"+ 
	    			 "</td>" +
	        	     "</tr>" +
	    			 "<tr>" +
	        	     "<td style=\"vertical-align: top;\">" +
	        	     "<table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\">" +
	        	     "<tbody>" +
	        	     "<tr>" +
	        	     "<td style=\"vertical-align: top\">" +
	        	     "<img src=\"https://www.ssafy.com/swp/images/edm/bg_left.png\" alt=\"\" style=\"vertical-align: top\" loading=\"lazy\">" +  
	        	     "</td>" +
	        	     "<td style=\"vertical-align: top; padding-top: 68px; width:680px; background: #fff\">" +
	        	     "<table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\">" +
	        	     "<tbody>" +
	        	     "<tr>" +
	        	     "<td style=\"font-family: '맑은 고딕', 'malgun gothic', 돋움, dotum, sans-serif; font-size: 24px; color:#000000; text-align: center\">" +
	        	     "이메일 수신 확인" +
	        	     "</td>" +
	        	     "</tr>" +
	        	     "<tr>" +
	        	     "<td style=\"text-align: center; line-height: 0; padding-top: 25px; padding-bottom: 25px;\">" +
	        	     "<img src=\"https://www.ssafy.com/swp/images/edm/bar.gif\" alt=\"\" style=\"vertical-align: top\" loading=\"lazy\">" +
	        	     "</td>" +
	        	     "</tr>" +
	        	     "<tr>" +
	        	     "<td style=\"font-family: '맑은 고딕', 'malgun gothic', 돋움, dotum, sans-serif; font-size: 18px; mso-line-height-rule: exactly; line-height: 26px; color: #6e7c8c; text-align: center\">" +
	        	     "<br>" +
	        	     "메일주소 확인을 위해 발송된 메일 입니다." +
	        	     "<br>" +
	        	     "아래 " +
	        	     "<span style=\"color:#3c90e2\">인증번호</span>" +
	        	     "를 복사하신 후 이메일 인증번호 입력란에" +
	        	     "<br>" +
	        	     "입력해 주시기 바랍니다." +
	        	     "</td>" +
	        	     "</tr>" +
	        	     "<tr>" +
	        	     "<td style=\"text-align: center; padding-top: 28px; padding-bottom: 80px\">" +
	        	     "<p style=\"color:#277bdc; font-size:25px; font-weight:700;\">" + authKey + " </p>" +
	        	     "</td>" +
	        	     "</tr>" +   
	        	     "</tbody>" +
	        	     "</table>" +
	        	     "</td>" +
	        	     "<td style=\"vertical-align: top\">" +
	        	     "<img src=\"https://www.ssafy.com/swp/images/edm/bg_right.png\" alt=\"\" style=\"vertical-align: top\" loading=\"lazy\">" +
	        	     "</td>" +
	        	     "</tr>" +
	        	     "</tbody>" +
	        	     "</table>" +
	    			 "</td>" +    	     
	        	     "</tr>" +
	    			 "<tr>" +
	        	     "<td height=\"28\" style=\"vertical-align: top\">" +
	    			 "<img src=\"https://www.ssafy.com/swp/images/edm/bg_btm.png\" alt=\"\" style=\"vertical-align: top;\" loading=\"lazy\">" +
	    			 "</td>" +
	        	     "</tr>" +
	    			 "</tbody>" +     
	        	     "</table>" +
	    			 "</div>" +
	        	     "</td>" +
	    			 "</tr>" +
	        	     "</tbody>" +
	        	     "</table>" +
	        	     "</BODY>" +
	        	     "</HTML>";
	        
	        //인증메일 보내기
	        try {
	            MailUtils sendMail = new MailUtils(mailSender);
	            sendMail.setSubject("비밀번호 찾기 인증번호 전송");
	            sendMail.setText(htmlText);
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

	        String htmlText = "<HTML>" +
	        	     "<HEAD></HEAD>" +
	        	     "<BODY>" +
	        	     "<table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" style=\"background: #f0f4f6;\">" +
	    			 "<tbody>" +
	        	     "<tr>" +
	    			 "<td>" +
	        	     "<div style=\"width: 712px; margin: 0 auto\">" +
	    			 "<table cellspacing=\"0\" cellpadding=\"0\" width=\"712\">" +
	        	     "<tbody>" +
	    			 "<tr text-align: center;>" +
	        	     "<td style=\"padding-top: 56px; padding-bottom: 22px; padding-left: 16px; text-align: center;\">" +
	        	     "<img src=\"http://localhost:8282/into/resources/main/assets/img/logo/logo.png\"></img>"+ 
	    			 "</td>" +
	        	     "</tr>" +
	    			 "<tr>" +
	        	     "<td style=\"vertical-align: top;\">" +
	        	     "<table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\">" +
	        	     "<tbody>" +
	        	     "<tr>" +
	        	     "<td style=\"vertical-align: top\">" +
	        	     "<img src=\"https://www.ssafy.com/swp/images/edm/bg_left.png\" alt=\"\" style=\"vertical-align: top\" loading=\"lazy\">" +  
	        	     "</td>" +
	        	     "<td style=\"vertical-align: top; padding-top: 68px; width:680px; background: #fff\">" +
	        	     "<table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\">" +
	        	     "<tbody>" +
	        	     "<tr>" +
	        	     "<td style=\"font-family: '맑은 고딕', 'malgun gothic', 돋움, dotum, sans-serif; font-size: 24px; color:#000000; text-align: center\">" +
	        	     "이메일 수신 확인" +
	        	     "</td>" +
	        	     "</tr>" +
	        	     "<tr>" +
	        	     "<td style=\"text-align: center; line-height: 0; padding-top: 25px; padding-bottom: 25px;\">" +
	        	     "<img src=\"https://www.ssafy.com/swp/images/edm/bar.gif\" alt=\"\" style=\"vertical-align: top\" loading=\"lazy\">" +
	        	     "</td>" +
	        	     "</tr>" +
	        	     "<tr>" +
	        	     "<td style=\"font-family: '맑은 고딕', 'malgun gothic', 돋움, dotum, sans-serif; font-size: 18px; mso-line-height-rule: exactly; line-height: 26px; color: #6e7c8c; text-align: center\">" +
	        	     "<br>" +
	        	     "메일주소 확인을 위해 발송된 메일 입니다." +
	        	     "<br>" +
	        	     "아래 " +
	        	     "<span style=\"color:#3c90e2\">인증번호</span>" +
	        	     "를 복사하신 후 이메일 인증번호 입력란에" +
	        	     "<br>" +
	        	     "입력해 주시기 바랍니다." +
	        	     "</td>" +
	        	     "</tr>" +
	        	     "<tr>" +
	        	     "<td style=\"text-align: center; padding-top: 28px; padding-bottom: 80px\">" +
	        	     "<p style=\"color:#277bdc; font-size:25px; font-weight:700;\">" + authKey + " </p>" +
	        	     "</td>" +
	        	     "</tr>" +   
	        	     "</tbody>" +
	        	     "</table>" +
	        	     "</td>" +
	        	     "<td style=\"vertical-align: top\">" +
	        	     "<img src=\"https://www.ssafy.com/swp/images/edm/bg_right.png\" alt=\"\" style=\"vertical-align: top\" loading=\"lazy\">" +
	        	     "</td>" +
	        	     "</tr>" +
	        	     "</tbody>" +
	        	     "</table>" +
	    			 "</td>" +    	     
	        	     "</tr>" +
	    			 "<tr>" +
	        	     "<td height=\"28\" style=\"vertical-align: top\">" +
	    			 "<img src=\"https://www.ssafy.com/swp/images/edm/bg_btm.png\" alt=\"\" style=\"vertical-align: top;\" loading=\"lazy\">" +
	    			 "</td>" +
	        	     "</tr>" +
	    			 "</tbody>" +     
	        	     "</table>" +
	    			 "</div>" +
	        	     "</td>" +
	    			 "</tr>" +
	        	     "</tbody>" +
	        	     "</table>" +
	        	     "</BODY>" +
	        	     "</HTML>";
	        
	        //인증메일 보내기
	        try {
	            MailUtils sendMail = new MailUtils(mailSender);
	            sendMail.setSubject("아이디 찾기 인증번호 전송");
	            sendMail.setText(htmlText);
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
	    
	    //email변경할때 메일 전송
	    @Transactional
	    public void emailChangeMail(String email) {

	        String htmlText = "<HTML>" +
	        	     "<HEAD></HEAD>" +
	        	     "<BODY>" +
	        	     "<table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" style=\"background: #f0f4f6;\">" +
	    			 "<tbody>" +
	        	     "<tr>" +
	    			 "<td>" +
	        	     "<div style=\"width: 712px; margin: 0 auto\">" +
	    			 "<table cellspacing=\"0\" cellpadding=\"0\" width=\"712\">" +
	        	     "<tbody>" +
	    			 "<tr text-align: center;>" +
	        	     "<td style=\"padding-top: 56px; padding-bottom: 22px; padding-left: 16px; text-align: center;\">" +
	        	     "<img src=\"http://localhost:8282/into/resources/main/assets/img/logo/logo.png\"></img>"+ 
	    			 "</td>" +
	        	     "</tr>" +
	    			 "<tr>" +
	        	     "<td style=\"vertical-align: top;\">" +
	        	     "<table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\">" +
	        	     "<tbody>" +
	        	     "<tr>" +
	        	     "<td style=\"vertical-align: top\">" +
	        	     "<img src=\"https://www.ssafy.com/swp/images/edm/bg_left.png\" alt=\"\" style=\"vertical-align: top\" loading=\"lazy\">" +  
	        	     "</td>" +
	        	     "<td style=\"vertical-align: top; padding-top: 68px; width:680px; background: #fff\">" +
	        	     "<table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\">" +
	        	     "<tbody>" +
	        	     "<tr>" +
	        	     "<td style=\"font-family: '맑은 고딕', 'malgun gothic', 돋움, dotum, sans-serif; font-size: 24px; color:#000000; text-align: center\">" +
	        	     "이메일 수신 확인" +
	        	     "</td>" +
	        	     "</tr>" +
	        	     "<tr>" +
	        	     "<td style=\"text-align: center; line-height: 0; padding-top: 25px; padding-bottom: 25px;\">" +
	        	     "<img src=\"https://www.ssafy.com/swp/images/edm/bar.gif\" alt=\"\" style=\"vertical-align: top\" loading=\"lazy\">" +
	        	     "</td>" +
	        	     "</tr>" +
	        	     "<tr>" +
	        	     "<td style=\"font-family: '맑은 고딕', 'malgun gothic', 돋움, dotum, sans-serif; font-size: 18px; mso-line-height-rule: exactly; line-height: 26px; color: #6e7c8c; text-align: center\">" +
	        	     "<br>" +
	        	     "이메일 변경 확인을 위해 발송된 메일 입니다." +
	        	     "<br>" +
	        	     "아래 " +
	        	     "<span style=\"color:#3c90e2\">이메일 변경 버튼</span>" +
	        	     "을 클릭하여 이메일 변경을" +
	        	     "<br>" +
	        	     "완료해주시기 바랍니다." +
	        	     "</td>" +
	        	     "</tr>" +
	        	     "<tr>" +
	        	     "<td style=\"text-align: center; padding-top: 28px; padding-bottom: 80px\">" +
	        	     "<a href='http://localhost:8282/into/alterEmail?email=" + email + "'target='_blenk'><button style=\"border: 0; outline: 0px; background-color: #3c90e2; width:100px; height:45px; color: white;\" rel=\"noreferrer noopener\">이메일 변경</button></a>" + 
	        	     "</td>" +
	        	     "</tr>" +   
	        	     "</tbody>" +
	        	     "</table>" +
	        	     "</td>" +
	        	     "<td style=\"vertical-align: top\">" +
	        	     "<img src=\"https://www.ssafy.com/swp/images/edm/bg_right.png\" alt=\"\" style=\"vertical-align: top\" loading=\"lazy\">" +
	        	     "</td>" +
	        	     "</tr>" +
	        	     "</tbody>" +
	        	     "</table>" +
	    			 "</td>" +    	     
	        	     "</tr>" +
	    			 "<tr>" +
	        	     "<td height=\"28\" style=\"vertical-align: top\">" +
	    			 "<img src=\"https://www.ssafy.com/swp/images/edm/bg_btm.png\" alt=\"\" style=\"vertical-align: top;\" loading=\"lazy\">" +
	    			 "</td>" +
	        	     "</tr>" +
	    			 "</tbody>" +     
	        	     "</table>" +
	    			 "</div>" +
	        	     "</td>" +
	    			 "</tr>" +
	        	     "</tbody>" +
	        	     "</table>" +
	        	     "</BODY>" +
	        	     "</HTML>";
	        
	        //인증메일 보내기
	        try {
	            MailUtils sendMail = new MailUtils(mailSender);
	            sendMail.setSubject("이메일 변경확인 메일");
	            sendMail.setText(htmlText);
	            sendMail.setFrom("hanrnj22@gmail.com", "같이투자");
	            sendMail.setTo(email);
	            sendMail.send();
	        } catch (MessagingException e) {
	            e.printStackTrace();
	        } catch (UnsupportedEncodingException e) {
	            e.printStackTrace();
	        }
	    }	    
	    
}
