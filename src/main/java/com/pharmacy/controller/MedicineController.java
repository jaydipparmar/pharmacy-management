package com.pharmacy.controller;

import com.pharmacy.model.Medicine;
import com.pharmacy.repository.MedicineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/medicines")
public class MedicineController {

    @Autowired
    private MedicineRepository medicineRepository;

    @GetMapping
    public List<Medicine> getAll() {
        return medicineRepository.findAll();
    }

    @PostMapping
    public Medicine create(@RequestBody Medicine medicine) {
        return medicineRepository.save(medicine);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Medicine> update(@PathVariable Long id, @RequestBody Medicine details) {
        return medicineRepository.findById(id).map(medicine -> {
            medicine.setName(details.getName());
            medicine.setBatchNo(details.getBatchNo());
            if (details.getSupplier() != null) {
                medicine.setSupplier(details.getSupplier());
            }
            medicine.setStockQuantity(details.getStockQuantity());
            medicine.setMinStockLevel(details.getMinStockLevel());
            medicine.setPrice(details.getPrice());
            medicine.setExpiryDate(details.getExpiryDate());
            return ResponseEntity.ok(medicineRepository.save(medicine));
        }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable Long id) {
        return medicineRepository.findById(id).map(medicine -> {
            medicineRepository.delete(medicine);
            return ResponseEntity.ok().build();
        }).orElse(ResponseEntity.notFound().build());
    }
}
