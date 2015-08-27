package vn.chonsoft.lixi.validations;

import java.util.regex.Pattern;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class PasswordValidator
        implements ConstraintValidator<Password, String>
{
    @Override
    public void initialize(Password annotation)
    {

    }

    @Override
    public boolean isValid(String password, ConstraintValidatorContext context)
    {
        if(password == null) return false;
        //
        boolean isAtLeast8   = password.length() >= 8;//Checks for at least 8 characters
        boolean hasUppercase = !password.equals(password.toLowerCase());
        boolean containNumber = password.matches(".*[0-9].*");
        //special chars
        String special = "!@#$%^&*()_";
        String pattern = ".*[" + Pattern.quote(special) + "].*";

        boolean specChars = password.matches(pattern);
        
        return (isAtLeast8 && hasUppercase && containNumber && specChars);
    }
}
