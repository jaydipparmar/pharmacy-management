package com.pharmacy.controller;

import com.pharmacy.model.User;
import com.pharmacy.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody User loginReq) {
        Optional<User> userOpt = userRepository.findByUsername(loginReq.getUsername());
        if (userOpt.isPresent() && userOpt.get().getPassword().equals(loginReq.getPassword())) {
            User user = userOpt.get();
            Map<String, Object> response = new HashMap<>();
            response.put("id", user.getId());
            response.put("username", user.getUsername());
            response.put("role", user.getRole());
            return ResponseEntity.ok(response);
        }
        return ResponseEntity.status(401).body("Invalid credentials");
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody User user) {
        if (userRepository.findByUsername(user.getUsername()).isPresent()) {
            return ResponseEntity.badRequest().body("Username already exists");
        }
        // Simplified mapping, raw password used for AJP mini project simplicity
        user.setRole(user.getRole() != null ? user.getRole() : "STAFF");
        User savedUser = userRepository.save(user);
        return ResponseEntity.ok(savedUser);
    }
}
