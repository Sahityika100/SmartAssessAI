package com.example.entity;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@Component
public class StudentReport {

	private int id;
	private String name;
	private String phone;
	private String email;
	private int ntest;
	private double percentage;
	private String statues;
	private String role;
}
