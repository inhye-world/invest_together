package bit.it.into.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Service;


@Service
public class UserLoginSuccessHandler implements AuthenticationSuccessHandler {

	private String loginid;
    private String defaultUrl;
 
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
    }
 
    public String getLoginid() {
        return loginid;
    }
 
    public void setLoginid(String loginid) {
        this.loginid = loginid;
    }
 
    public String getDefaultUrl() {
        return defaultUrl;
    }
 
    public void setDefaultUrl(String defaultUrl) {
        this.defaultUrl = defaultUrl;
    }

}
