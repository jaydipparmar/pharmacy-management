package com.pharmacy;

import com.pharmacy.model.Medicine;
import com.pharmacy.model.Supplier;
import com.pharmacy.repository.MedicineRepository;
import com.pharmacy.repository.SupplierRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.time.LocalDate;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private SupplierRepository supplierRepository;

    @Autowired
    private MedicineRepository medicineRepository;

    @Override
    public void run(String... args) throws Exception {
        if (supplierRepository.count() == 0 && medicineRepository.count() == 0) {
            // Seed Suppliers
            Supplier s1 = new Supplier();
            s1.setName("PharmaGlobal Distributors");
            s1.setContactNumber("1-800-555-0199");
            s1.setEmail("supply@pharmaglobal.com");
            s1.setAddress("123 Industrial Way, Tech City");
            supplierRepository.save(s1);

            Supplier s2 = new Supplier();
            s2.setName("MediCare Solutions");
            s2.setContactNumber("1-800-555-0200");
            s2.setEmail("orders@medicare.net");
            s2.setAddress("88 Health Blvd, Wellness State");
            supplierRepository.save(s2);

            // Seed Medicines
            Medicine m1 = new Medicine();
            m1.setName("Amoxicillin 500mg");
            m1.setBatchNo("AMOX-2026-A1");
            m1.setPrice(12.50);
            m1.setStockQuantity(150);
            m1.setMinStockLevel(20);
            m1.setExpiryDate(LocalDate.now().plusYears(1));
            m1.setSupplier(s1);
            medicineRepository.save(m1);

            Medicine m2 = new Medicine();
            m2.setName("Ibuprofen 400mg");
            m2.setBatchNo("IBU-400-B9");
            m2.setPrice(6.99);
            m2.setStockQuantity(10); // Low stock trigger
            m2.setMinStockLevel(50);
            m2.setExpiryDate(LocalDate.now().plusMonths(8));
            m2.setSupplier(s2);
            medicineRepository.save(m2);

            Medicine m3 = new Medicine();
            m3.setName("Lisinopril 10mg");
            m3.setBatchNo("LIS-10-C3");
            m3.setPrice(18.20);
            m3.setStockQuantity(200);
            m3.setMinStockLevel(30);
            m3.setExpiryDate(LocalDate.now().plusDays(15)); // Expiry trigger
            m3.setSupplier(s1);
            medicineRepository.save(m3);

            Medicine m4 = new Medicine();
            m4.setName("Cetirizine 10mg");
            m4.setBatchNo("CET-10-D4");
            m4.setPrice(8.00);
            m4.setStockQuantity(80);
            m4.setMinStockLevel(25);
            m4.setExpiryDate(LocalDate.now().plusYears(2));
            m4.setSupplier(s2);
            medicineRepository.save(m4);

            System.out.println("Dummy Data Initialized Successfully.");
        }
    }
}
