package com.pharmacy.controller;

import com.pharmacy.model.Medicine;
import com.pharmacy.model.Sale;
import com.pharmacy.model.SaleItem;
import com.pharmacy.repository.MedicineRepository;
import com.pharmacy.repository.SaleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/sales")
public class SaleController {

    @Autowired
    private SaleRepository saleRepository;

    @Autowired
    private MedicineRepository medicineRepository;

    @GetMapping
    public List<Sale> getAllSales() {
        return saleRepository.findAll();
    }

    @PostMapping
    @Transactional
    public ResponseEntity<?> createSale(@RequestBody Sale sale) {
        sale.setSaleDate(LocalDateTime.now());
        
        double total = 0.0;
        
        if (sale.getItems() != null) {
            for (SaleItem item : sale.getItems()) {
                if (item.getMedicine() == null || item.getMedicine().getId() == null) {
                    return ResponseEntity.badRequest().body("Invalid medicine details in sale item");
                }
                Medicine medicine = medicineRepository.findById(item.getMedicine().getId()).orElse(null);
                if (medicine == null) {
                    return ResponseEntity.badRequest().body("Medicine not found");
                }
                if (medicine.getStockQuantity() < item.getQuantity()) {
                    return ResponseEntity.badRequest().body("Not enough stock for " + medicine.getName());
                }
                
                // Deduct stock
                medicine.setStockQuantity(medicine.getStockQuantity() - item.getQuantity());
                medicineRepository.save(medicine);
                
                item.setSale(sale);
                item.setPriceAtSale(medicine.getPrice());
                
                total += (item.getPriceAtSale() * item.getQuantity());
            }
        }
        
        sale.setTotalAmount(total);
        Sale savedSale = saleRepository.save(sale);
        return ResponseEntity.ok(savedSale);
    }
}
