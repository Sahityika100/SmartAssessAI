package com.example.jwt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;
import com.example.entity.User;
import com.example.service.UserService;

@Component
public class AdminInitializer implements CommandLineRunner {

    @Autowired
    private UserService userService;

    @Value("${admin.email}")
    private String adminEmail;

    @Value("${admin.password}")
    private String adminPassword;

    @Value("${admin.name}")
    private String adminName;

    @Value("${admin.phone}")
    private String adminPhone;

    @Override
    public void run(String... args) throws Exception {
        User existingAdmin = userService.findByEmail(adminEmail);
        if (existingAdmin == null) {
            User admin = new User();
            admin.setName(adminName);
            admin.setEmail(adminEmail);
            admin.setPassword(adminPassword);
            admin.setPhone(adminPhone);
            admin.setRole("admin");
            userService.register(admin);
            System.out.println("Admin created automatically!");
        }
    }
}