package com.example.demo.student;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.LocalDate;
import java.time.Month;
import java.util.List;

@Configuration
public class StudentConfig {

    @Bean
    CommandLineRunner commandLineRunner(StudentRepository repository) {
        return args -> {
                Student alex = new Student(
                        "Alex",
                        "developer@gmail.com",
                        LocalDate.of(1995, Month.FEBRUARY, 25)
            );

            Student jack = new Student(
                    "jack",
                    "jockloper@gmail.com",
                    LocalDate.of(1992, Month.FEBRUARY, 15)
            );

            repository.saveAll(List.of(alex, jack));
        };
    }
}
