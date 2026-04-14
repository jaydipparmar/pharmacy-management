package com.pharmacy.repository;

import com.pharmacy.model.Alert;
import com.pharmacy.model.Medicine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AlertRepository extends JpaRepository<Alert, Long> {
    List<Alert> findByIsResolvedFalse();
    Alert findByMedicineAndAlertTypeAndIsResolvedFalse(Medicine medicine, String alertType);
}
