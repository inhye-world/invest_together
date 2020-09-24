package bit.it.into.dto;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ValidMemberDTO {
   
   @NotEmpty
   @Size(min=4, max=12)
   @Pattern(regexp = "^[a-z0-9]+$", message = "¿µ¹®°ú ¼ýÀÚ°¡ È¥ÇÕµÈ ¾ÆÀÌµð¸¦ ÀÔ·ÂÇØ ÁÖ¼¼¿ä.")
   private String id;
   
   @NotEmpty
   @Pattern(regexp="(?=.*[0-9])(?=.*[a-zA-Z]).{8,32}", message = "¿µ¹®°ú ¼ýÀÚ°¡ Æ÷ÇÔµÈ ºñ¹Ð¹øÈ£¸¦ ÀÔ·ÂÇØ ÁÖ¼¼¿ä. ")
   private String pw;
   
   @NotEmpty
   @Size(min=2, max=8)
   @Pattern(regexp = "^[°¡-ÆR]+$", message = "Çü½Ä¿¡ ¸ÂÁö ¾Ê½À´Ï´Ù.")
   private String name;
   
   @NotEmpty
   @Size(min=2, max=8)
   @Pattern(regexp = "^[°¡-ÆRa-zA-Z0-9]+$", message = "Çü½Ä¿¡ ¸ÂÁö ¾Ê½À´Ï´Ù.")
   private String nickname;
   
   @NotEmpty
   @Email
   private String email;
   
   @NotEmpty
   @Pattern(regexp="^01(?:0|1|[6-9])(?:\\d{3}|\\d{4})\\d{4}$", message = "Çü½Ä¿¡ ¸ÂÁö ¾Ê½À´Ï´Ù.")
   private String phone;

}
