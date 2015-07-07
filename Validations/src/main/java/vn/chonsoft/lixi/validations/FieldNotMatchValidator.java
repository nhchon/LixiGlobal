package vn.chonsoft.lixi.validations;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import org.apache.commons.beanutils.BeanUtils;

public class FieldNotMatchValidator
        implements ConstraintValidator<FieldNotMatch, Object> {

    private String firstFieldName;
    private String secondFieldName;
    private String message;

    @Override
    public void initialize(final FieldNotMatch annotation) {
        firstFieldName = annotation.first();
        secondFieldName = annotation.second();
        message = annotation.message();
    }

    @Override
    public boolean isValid(Object value, ConstraintValidatorContext context) {
        try {
            final Object firstObj = BeanUtils.getProperty(value, firstFieldName);
            final Object secondObj = BeanUtils.getProperty(value, secondFieldName);
            boolean isValid = (firstObj == null && secondObj == null) || (firstObj != null
                    && !firstObj.equals(secondObj)) || (secondObj != null
                    && !secondObj.equals(firstObj));

            if (!isValid) {
                context.disableDefaultConstraintViolation();
                context
                        .buildConstraintViolationWithTemplate(message)
                        .addPropertyNode(secondFieldName).addConstraintViolation();
            }

            return isValid;
        } catch (final Exception ignore) {
            // ignore
        }
        return true;
    }
}
