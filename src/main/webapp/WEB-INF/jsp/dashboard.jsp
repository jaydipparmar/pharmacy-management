<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SmartPharma - Dashboard</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="app-container">
        <jsp:include page="sidebar.jsp" />
        
        <main class="main-content">
            <div class="topbar">
                <div>
                    <h1 class="heading-large">Dashboard</h1>
                    <p class="text-muted">Welcome to SmartPharma Admin Panel</p>
                </div>
            </div>

            <div class="stat-grid">
                <div class="glass-panel stat-card">
                    <div class="flex-between">
                        <span class="text-muted">Total Revenue</span>
                        <span style="color: var(--success-color)">&#8593;</span>
                    </div>
                    <div class="stat-value" id="totalRev">₹0.00</div>
                </div>
                <div class="glass-panel stat-card">
                    <div class="flex-between">
                        <span class="text-muted">Total Medicines</span>
                    </div>
                    <div class="stat-value" id="totalMeds">0</div>
                </div>
            </div>

            <h2 style="margin-top: 2rem; margin-bottom: 1rem;">Active Alerts</h2>
            <div id="alertsContainer">
                <!-- Alerts injected here via JS -->
            </div>
        </main>
    </div>

    <script>
        async function fetchStats() {
            const salesRes = await fetch('/api/sales');
            const medRes = await fetch('/api/medicines');
            const sales = await salesRes.json();
            const meds = await medRes.json();
            
            const totalAmt = sales.reduce((acc, sum) => acc + sum.totalAmount, 0);
            document.getElementById('totalRev').innerHTML = '₹' + totalAmt.toFixed(2);
            document.getElementById('totalMeds').innerHTML = meds.length;
        }

        async function fetchAlerts() {
            const res = await fetch('/api/alerts');
            const alerts = await res.json();
            const container = document.getElementById('alertsContainer');
            
            if(alerts.length === 0) {
                container.innerHTML = '<div class="glass-panel" style="text-align: center; padding: 3rem;"><p class="text-muted">No active alerts. Everything is running smoothly!</p></div>';
                return;
            }

            container.innerHTML = '';
            alerts.forEach(alert => {
                const color = alert.alertType === 'EXPIRY' ? 'var(--danger-color)' : 'var(--warning-color)';
                const title = alert.alertType === 'EXPIRY' ? 'Needs Attention: Expiry' : 'Low Stock Warning';
                
                container.innerHTML += `
                    <div class="glass-panel" style="display: flex; justify-content: space-between; align-items: center; padding: 1.5rem; margin-bottom: 1rem; border-left: 4px solid \${color}">
                        <div>
                            <h4 style="color: var(--text-primary);">\${title}</h4>
                            <p class="text-muted">\${alert.message}</p>
                        </div>
                        <button class="btn-success" style="width: auto" onclick="resolveAlert(\${alert.id})">Mark Resolved</button>
                    </div>
                `;
            });
        }

        async function resolveAlert(id) {
            await fetch('/api/alerts/' + id + '/resolve', { method: 'PUT' });
            fetchAlerts();
        }

        fetchStats();
        fetchAlerts();
    </script>
</body>
</html>
