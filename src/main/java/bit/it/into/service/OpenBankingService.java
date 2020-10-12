package bit.it.into.service; 

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
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
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class OpenBankingService {
	
	private final static String O_CLIENT_ID = "nsnQFpOeHW8eVl9ts8IUarVt6YTmjUD13BQCAWN7";
	private final static String O_CLIENT_SECRET= "wxCyk0X6XVnORsK4G0fKybA7wLgnfzokNaRfjqir";
	private final static String O_REDIRECT_URI = "http://localhost:8282/into/user/addAccount";
	private final static String O_ORGANIZATION_CODE = "T991650480";
	
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
	
	public String getTranDtime() {
		long nano = System.currentTimeMillis();
		return new SimpleDateFormat("yyyyMMddHHmmss").format(nano);
	}
	
	public String getFromDate(String year, String month) {
		return year+month+"01";
	}
	
	public String getToDate(String year, String month) {
		
		LocalDate now = LocalDate.now();
		String nowYear = Integer.toString(now.getYear());
		String nowMonth = String.format("%02d", now.getMonthValue());

		if(nowYear.equals(year) && nowMonth.equals(month)) {
			String nowDay = String.format("%02d", now.getDayOfMonth());
			return year+month+nowDay;
		}
		
		
		YearMonth yearMonth = YearMonth.from(LocalDate.parse(year+month+"01", DateTimeFormatter.ofPattern("yyyyMMdd")));
		
		int lastday = yearMonth.lengthOfMonth();
		return year+month+lastday;
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
	
	
	public JsonNode getAccountBalance(String access_token, String fintech_use_num) {
		final String RequestUrl = "https://testapi.openbanking.or.kr/v2.0/account/balance/fin_num";
		
		final HttpClient client = HttpClientBuilder.create().build();
		
		final HttpGet get = new HttpGet( RequestUrl
											+"?fintech_use_num="+fintech_use_num
											+"&bank_tran_id="+getBankTranId()
											+"&tran_dtime="+getTranDtime() 
										);
		
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
	
	public JsonNode getAccountTransactionList(String access_token, String fintech_use_num, String year, String month) {
		final String RequestUrl = "https://testapi.openbanking.or.kr/v2.0/account/transaction_list/fin_num";
		
		final HttpClient client = HttpClientBuilder.create().build();
		
		final HttpGet get = new HttpGet( RequestUrl
											+"?fintech_use_num="+fintech_use_num
											+"&bank_tran_id="+getBankTranId()
											+"&tran_dtime="+getTranDtime() 
											+"&inquiry_type="+"A"
											+"&inquiry_base="+"D"
											+"&from_date="+getFromDate(year, month)
											+"&to_date="+getToDate(year, month)
											+"&sort_order="+"D"
										);
		
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
	
	//////////////////////////////////실질입금내역시험용/////////////////////////////////////////////
	public String getBreakdown(String access_token, String fintech_use_num,  String year, String month) throws UnsupportedEncodingException, IOException, ParseException {
		String param = "?bank_tran_id=" + getBankTranId() + "&fintech_use_num="
				+ fintech_use_num + "&inquiry_type=A" + "&inquiry_base=D" + "&from_date=" +getFromDate(year, month)+ "&to_date="+getToDate(year, month)
				+ "&sort_order=D" + "&tran_dtime="+getTranDtime();

		final String RequestUrl = "https://testapi.openbanking.or.kr/v2.0/account/transaction_list/fin_num" + param;
		
		URL url = new URL(RequestUrl);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		
		conn.setRequestProperty("Authorization", "Bearer " + access_token);
		conn.setDoOutput(true);
		
		int responseCode = conn.getResponseCode();
		System.out.println("responseCode4 : " + responseCode);
		
		InputStream is = conn.getInputStream();
		BufferedReader in = new BufferedReader(new InputStreamReader(is), 8 * 1024);
		
		String line = null;
		StringBuffer buff = new StringBuffer();
		
		while ((line = in.readLine()) != null) {
			buff.append(line + "\n");
		}
		
		String result = buff.toString().trim();
		return result;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////
	
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
