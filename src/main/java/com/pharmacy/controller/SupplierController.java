package com.pharmacy.controller;

import com.pharmacy.model.Supplier;
import com.pharmacy.repository.SupplierRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/suppliers")
public class SupplierController {

    @Autowired
    private SupplierRepository supplierRepository;

    @GetMapping
    public List<Supplier> getAll() {
        return supplierRepository.findAll();
    }

    @PostMapping
    public Supplier create(@RequestBody Supplier supplier) {
        return supplierRepository.save(supplier);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Supplier> update(@PathVariable Long id, @RequestBody Supplier details) {
        return supplierRepository.findById(id).map(supplier -> {
            supplier.setName(details.getName());
            supplier.setContactNumber(details.getContactNumber());
            supplier.setEmail(details.getEmail());
            supplier.setAddress(details.getAddress());
            return ResponseEntity.ok(supplierRepository.save(supplier));
        }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable Long id) {
        return supplierRepository.findById(id).map(supplier -> {
            supplierRepository.delete(supplier);
            return ResponseEntity.ok().build();
        }).orElse(ResponseEntity.notFound().build());
    }
}
