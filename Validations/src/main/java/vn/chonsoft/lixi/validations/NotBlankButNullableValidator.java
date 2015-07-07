package vn.chonsoft.lixi.validations;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class NotBlankButNullableValidator
        implements ConstraintValidator<NotBlankButNullable, String>
{
    @Override
    public void initialize(NotBlankButNullable annotation)
    {

    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context)
    {
        if(value == null || value.length()==0) return true;
        //
        return value.trim().length() > 0;
    }
}
