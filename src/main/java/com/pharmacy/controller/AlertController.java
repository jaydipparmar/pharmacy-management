package com.pharmacy.controller;

import com.pharmacy.model.Alert;
import com.pharmacy.repository.AlertRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/alerts")
public class AlertController {

    @Autowired
    private AlertRepository alertRepository;

    @GetMapping
    public List<Alert> getActiveAlerts() {
        return alertRepository.findByIsResolvedFalse();
    }

    @PutMapping("/{id}/resolve")
    public ResponseEntity<Alert> resolveAlert(@PathVariable Long id) {
        return alertRepository.findById(id).map(alert -> {
            alert.setIsResolved(true);
            return ResponseEntity.ok(alertRepository.save(alert));
        }).orElse(ResponseEntity.notFound().build());
    }
}
