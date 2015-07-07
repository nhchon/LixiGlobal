package vn.chonsoft.lixi.validations;

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
        
        return (isAtLeast8 && hasUppercase);
    }
}
