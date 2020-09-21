package bit.it.into.service; 

import java.util.ArrayList;
import java.util.List;
import java.util.Random;


import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class OpenBankingService {
	
	private final static String O_CLIENT_ID = "TmlHvtfDp4g3a4KxAqPlexXCgmUz7V5xKd8hNnSd";
	private final static String O_CLIENT_SECRET= "540RGNZttoNAaI3K1CvL36vlnPlltJsLL16I9X5z";
	private final static String O_REDIRECT_URI = "http://localhost:8282/into/user/addAccount";
	private final static String O_ORGANIZATION_CODE = "T991648810";
	
	public String getUrl() {
		String openUrl = 	"https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
								+"response_type=code" 
								+"&scope=login inquiry"
								+"&auth_type=0"
								+"&client_id=" + O_CLIENT_ID 
								+"&redirect_uri=" + O_REDIRECT_URI
								+"&state="+randomCode(32);
		return openUrl;
	}
	
	public String getBankTranId() {
		String bank_tran_id = O_ORGANIZATION_CODE+"U"+randomCode(9);
		
		return bank_tran_id;
	}
	
	
	
	public JsonNode getAccessToken(String autorize_code) {
		final String RequestUrl = "https://testapi.openbanking.or.kr/oauth/2.0/token";
		
		final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
		postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
		postParams.add(new BasicNameValuePair("client_id", O_CLIENT_ID));
		postParams.add(new BasicNameValuePair("client_secret", O_CLIENT_SECRET));
		postParams.add(new BasicNameValuePair("redirect_uri", O_REDIRECT_URI));
		postParams.add(new BasicNameValuePair("code", autorize_code));
		
		final HttpClient client = HttpClientBuilder.create().build();
		
		final HttpPost post = new HttpPost(RequestUrl);
		post.setHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		
		JsonNode returnNode = null;
		
		try {
			post.setEntity(new UrlEncodedFormEntity(postParams));
			final HttpResponse response = client.execute(post);
			ObjectMapper mapper = new ObjectMapper();
			returnNode = mapper.readTree(response.getEntity().getContent());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return returnNode;
	
	}	
	
	
	public JsonNode getUserInfo(String access_token, String user_seq_no) {
		final String RequestUrl = "https://testapi.openbanking.or.kr/v2.0/user/me";
		
		final HttpClient client = HttpClientBuilder.create().build();
		
		final HttpGet get = new HttpGet(RequestUrl+"?user_seq_no="+user_seq_no);
		
		get.addHeader("Authorization", "Bearer " + access_token);
		
		JsonNode returnNode = null;
		
		try {
			final HttpResponse response = client.execute(get);
			ObjectMapper mapper = new ObjectMapper();
			returnNode = mapper.readTree(response.getEntity().getContent());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return returnNode;
	}
	
	
	
	public String randomCode(int length){
		char[] charaters = 	{
								'0','1','2','3','4','5','6','7','8','9',
								'A','B','C','D','E','F','G','H','I','J',
								'K','L','M','N','O','P','Q','R','S','T',
								'U','V','W','X','Y','Z'
							};

        StringBuffer sb = new StringBuffer();
        Random rn = new Random();

        for(int i=0 ; i<length ; i++){
        	sb.append( charaters[rn.nextInt(charaters.length)] );
        }
        
        return sb.toString();
	}

	
}
