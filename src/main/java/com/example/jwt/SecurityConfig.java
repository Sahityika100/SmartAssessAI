package com.example.jwt;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        http
            .csrf().disable()
            .authorizeRequests()
            .antMatchers("/","/smartai/**", "/css/**",
            		"/courses/**","/test/**","/images/**","/admin/**").permitAll() // ✅ allow
            .anyRequest().authenticated()
            .and()
            .formLogin().disable(); // ❌ disable default login

        return http.build();
    }
}