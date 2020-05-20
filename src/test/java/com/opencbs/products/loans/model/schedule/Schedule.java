package com.opencbs.products.loans.model.schedule;

import lombok.Data;

import java.util.List;
import java.util.Objects;

@Data
public class Schedule {
    private List<String> columns;
    private List<String> types;
    private List<Installment> rows;
    private List<Object> totals;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Schedule schedule = (Schedule) o;
        return Objects.equals(columns, schedule.columns) &&
                Objects.equals(types, schedule.types) &&
                Objects.equals(rows, schedule.rows) &&
                Objects.equals(totals, schedule.totals);
    }

    @Override
    public int hashCode() {
        return Objects.hash(columns, types, rows, totals);
    }
}
