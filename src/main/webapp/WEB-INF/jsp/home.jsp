<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartPharma - Welcome</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="home-hero">
        <div>
            <!-- Pill/Cross Icon -->
            <svg class="feature-icon" width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-bottom: 1.5rem;"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M19 8v6"/><path d="M16 11h6"/></svg>
            
            <h1 class="home-title">SmartPharma Solution</h1>
            <p class="home-subtitle">
                The complete pharmacy management ecosystem. Track inventory explicitly, handle rapid POS billing, and automate expiry & stock alerting all from a beautiful, intuitive interface.
            </p>
            
            <div style="display: flex; gap: 1rem; justify-content: center;">
                <a href="/login" class="btn-primary" style="text-decoration: none;">Login to Portal</a>
                <a href="/signup" class="btn-primary" style="background: var(--bg-secondary); color: var(--primary-color); border: 1px solid var(--primary-color); text-decoration: none;">Create Account</a>
            </div>

            <div class="features-grid">
                <div class="glass-panel feature-card">
                    <svg class="feature-icon" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m7.5 4.27 9 5.15"/><path d="M21 8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16Z"/><path d="m3.3 7 8.7 5 8.7-5"/><path d="M12 22V12"/></svg>
                    <h3>Inventory Tracking</h3>
                    <p class="text-muted" style="margin-top: 0.5rem; font-size: 0.9rem;">Automated tracking of stock levels and smart notifications.</p>
                </div>
                <div class="glass-panel feature-card">
                    <svg class="feature-icon" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/></svg>
                    <h3>Rapid Terminal</h3>
                    <p class="text-muted" style="margin-top: 0.5rem; font-size: 0.9rem;">Lightning fast point of sale for executing transactions in seconds.</p>
                </div>
                <div class="glass-panel feature-card">
                    <svg class="feature-icon" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>
                    <h3>Expiry Alerts</h3>
                    <p class="text-muted" style="margin-top: 0.5rem; font-size: 0.9rem;">Never miss an expired medicine again with background scanning.</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
