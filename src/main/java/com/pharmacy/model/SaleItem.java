package com.pharmacy.model;

import jakarta.persistence.*;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "sale_items")
public class SaleItem {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "sale_id")
    @JsonIgnore
    private Sale sale;
    
    @ManyToOne
    @JoinColumn(name = "medicine_id")
    private Medicine medicine;
    
    @Column(nullable = false)
    private Integer quantity;
    
    @Column(nullable = false)
    private Double priceAtSale;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Sale getSale() { return sale; }
    public void setSale(Sale sale) { this.sale = sale; }
    public Medicine getMedicine() { return medicine; }
    public void setMedicine(Medicine medicine) { this.medicine = medicine; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    public Double getPriceAtSale() { return priceAtSale; }
    public void setPriceAtSale(Double priceAtSale) { this.priceAtSale = priceAtSale; }
}
