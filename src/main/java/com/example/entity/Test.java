package com.example.entity;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.*;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name="tests")

@ToString(exclude = {"student", "course", "questions"}) // 🔥 IMPORTANT
public class Test {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int score;

    private int totalQuestions;

    private int duration;

    private String difficulty;

    private LocalDateTime startTime;

    private LocalDateTime endTime;

    private LocalDateTime testDate;

    private String status;

    @ManyToOne
    @JoinColumn(name="student_id")
    private User student;

    @ManyToOne
    @JoinColumn(name="course_id")
    private Course course;

    @OneToMany(mappedBy="test", cascade = CascadeType.ALL)
    private List<Question> questions;
}