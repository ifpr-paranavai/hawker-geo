package com.kairo.hawker.converter;

import javax.persistence.AttributeConverter;

public class BooleanNotNullConverter implements AttributeConverter<Boolean, Boolean> {

    public Boolean convertToDatabaseColumn(Boolean value) {
        return value != null && value;
    }

    public Boolean convertToEntityAttribute(Boolean value) {
        return value;
    }
}
