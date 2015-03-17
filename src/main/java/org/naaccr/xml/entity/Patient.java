/*
 * Copyright (C) 2015 Information Management Services, Inc.
 */
package org.naaccr.xml.entity;

import java.util.ArrayList;
import java.util.List;

import org.naaccr.xml.NaaccrValidationError;

public class Patient extends AbstractEntity {
    
    protected List<Tumor> _tumors;

    public List<Tumor> getTumors() {
        if (_tumors == null)
            _tumors = new ArrayList<>();
        return _tumors;
    }
    
    public List<NaaccrValidationError> getAllValidationErrors() {
        List<NaaccrValidationError> results = new ArrayList<>(getValidationErrors());
        for (Tumor tumor : getTumors())
            results.addAll(tumor.getValidationErrors());
        return results;
    }
}
