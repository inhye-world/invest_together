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
   
   @NotEmpty(message="´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.")
   @Size(min=4, max=12, message="´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.")
   @Pattern(regexp = "^[a-z0-9]+$", message="´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.")
   private String id;
   
   @NotEmpty(message = "´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.")
   @Pattern(regexp="(?=.*[0-9])(?=.*[a-zA-Z]).{8,32}", message="´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.")
   private String pw;
   
   @NotEmpty(message = "´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.")
   @Size(min=2, max=8, message="´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.")
   @Pattern(regexp = "^[°¡-ÆR]+$", message="´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.")
   private String name;
   
   @NotEmpty(message = "´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.")
   @Size(min=2, max=8, message="´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.")
   @Pattern(regexp = "^[°¡-ÆRa-zA-Z0-9]+$", message="´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.")
   private String nickname;
   
   @NotEmpty(message = "´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.")
   @Email(message = "´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.")
   private String email;
   
   @NotEmpty(message = "´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.")
   @Pattern(regexp="^01(?:0|1|[6-9])(?:\\d{3}|\\d{4})\\d{4}$", message = "´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.")
   private String phone;
}
