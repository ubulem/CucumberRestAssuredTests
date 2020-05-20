package com.opencbs.products.loans.model.schedule;

import lombok.Data;

import java.util.List;
import java.util.Objects;

@Data
public class Installment {
    private String overdue;
    private List<Object> data;
    private String status;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Installment that = (Installment) o;
        return Objects.equals(overdue, that.overdue) &&
                Objects.equals(data, that.data) &&
                Objects.equals(status, that.status);
    }

    @Override
    public int hashCode() {
        return Objects.hash(overdue, data, status);
    }

}
