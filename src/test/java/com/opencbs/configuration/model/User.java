package com.opencbs.configuration.model;

import com.google.gson.annotations.Expose;
import lombok.Data;

@Data
public class User {
    private long id;
    private String username;
    private String password;
    private String firstName;
    private String lastName;
    private int roleId;
    @Expose(serialize = false)
    private String roleName;
    private int branchId;
    private String email;
    private String phoneNumber;
    private String address;
    private String idNumber;
    private String position;
    private String statusType;
}
