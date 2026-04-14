package com.pharmacy.service;

import com.pharmacy.model.Alert;
import com.pharmacy.model.Medicine;
import com.pharmacy.repository.AlertRepository;
import com.pharmacy.repository.MedicineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
public class AlertService {

    @Autowired
    private MedicineRepository medicineRepository;

    @Autowired
    private AlertRepository alertRepository;

    // Run every day at midnight (or every minute for testing: "0 * * * * *")
    // Using every 1 minute here so the user can easily test the background job
    @Scheduled(cron = "0 * * * * *")
    @Transactional
    public void generateAlerts() {
        List<Medicine> medicines = medicineRepository.findAll();
        LocalDate now = LocalDate.now();

        for (Medicine m : medicines) {
            // Check Low Stock
            if (m.getStockQuantity() <= m.getMinStockLevel()) {
                createAlertIfNotExists(m, "LOW_STOCK", 
                    String.format("Low stock for %s. Current: %d, Min: %d", 
                        m.getName(), m.getStockQuantity(), m.getMinStockLevel()));
            }

            // Check Expiry (within 30 days)
            if (m.getExpiryDate() != null && m.getExpiryDate().isBefore(now.plusDays(30))) {
                createAlertIfNotExists(m, "EXPIRY", 
                    String.format("Medicine %s is expiring soon on %s", 
                        m.getName(), m.getExpiryDate().toString()));
            }
        }
    }

    private void createAlertIfNotExists(Medicine medicine, String alertType, String message) {
        Alert existingAlert = alertRepository.findByMedicineAndAlertTypeAndIsResolvedFalse(medicine, alertType);
        if (existingAlert == null) {
            Alert newAlert = new Alert();
            newAlert.setMedicine(medicine);
            newAlert.setAlertType(alertType);
            newAlert.setMessage(message);
            alertRepository.save(newAlert);
        }
    }
}
