package bit.it.into.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class IamportService {
	private final static String IMP_ID = "4318775745571382";
	private final static String IMP_SECRET = "XDXZcNfE7lxT73EwzdiJA81rK098QprO3pNfc3TjprdwuR245kNGtO7dPhmFGNuKciZplSIKkWgPNjTT";

	public JsonNode getAccessToken() {
		final String RequestUrl = "https://api.iamport.kr/users/getToken";
		
		final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
		postParams.add(new BasicNameValuePair("imp_key", IMP_ID));
		postParams.add(new BasicNameValuePair("imp_secret", IMP_SECRET));
		
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

	
	public JsonNode cancelPayment(String merchant_uid, String reason, String access_token) {
		final String RequestUrl = "https://api.iamport.kr/payments/cancel";
		
		final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
		postParams.add(new BasicNameValuePair("merchant_uid", merchant_uid));
		postParams.add(new BasicNameValuePair("reason", reason));
		
		final HttpClient client = HttpClientBuilder.create().build();
		
		final HttpPost post = new HttpPost(RequestUrl);
		post.setHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		post.addHeader("Authorization", access_token);
		
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


}
