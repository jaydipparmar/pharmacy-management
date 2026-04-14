<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SmartPharma - Inventory</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="app-container">
        <jsp:include page="sidebar.jsp" />
        
        <main class="main-content">
            <div class="topbar">
                <div>
                    <h1 class="heading-large">Inventory Management</h1>
                    <p class="text-muted">Manage available medicines and stock</p>
                </div>
                <button id="addMedBtn" class="btn-primary" style="width: auto; display: none;" onclick="openAddForm()">+ Add Medicine</button>
            </div>

            <div id="addMedForm" class="glass-panel" style="display: none; margin-bottom: 2rem;">
                <h3>Add New Medicine</h3>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-top: 1rem;">
                    <input type="text" id="mName" placeholder="Name" class="glass-input">
                    <input type="text" id="mBatch" placeholder="Batch No (e.g. B101)" class="glass-input">
                    <input type="number" id="mStock" placeholder="Stock Quantity" class="glass-input">
                    <input type="number" id="mMinStock" placeholder="Min Stock Level" class="glass-input">
                    <input type="number" step="0.01" id="mPrice" placeholder="Price" class="glass-input">
                    <input type="date" id="mExpiry" class="glass-input">
                </div>
                <div style="margin-top: 1rem;">
                    <button class="btn-primary" style="width: auto;" onclick="submitMedicine()">Save</button>
                    <button class="btn-danger" style="width: auto; margin-left: 1rem;" onclick="closeMedForm()">Cancel</button>
                </div>
            </div>

            <div class="glass-panel" style="padding: 0; overflow: hidden;">
                <table class="glass-table">
                    <thead>
                        <tr>
                            <th>ID</th><th>Name</th><th>Batch No</th><th>Stock</th><th>Price</th><th>Expiry Date</th><th>Status</th><th class="admin-only" style="display:none;">Action</th>
                        </tr>
                    </thead>
                    <tbody id="medTableBody">
                    </tbody>
                </table>
            </div>
        </main>
    </div>

    <script>
        let medicinesList = [];
        let editingId = null;

        function openAddForm() {
            editingId = null;
            document.getElementById('addMedForm').style.display = 'block';
            document.querySelector('#addMedForm h3').innerText = 'Add New Medicine';
            document.getElementById('mName').value = '';
            document.getElementById('mBatch').value = '';
            document.getElementById('mStock').value = '';
            document.getElementById('mMinStock').value = '';
            document.getElementById('mPrice').value = '';
            document.getElementById('mExpiry').value = '';
        }

        function openEditForm(med) {
            editingId = med.id;
            document.getElementById('addMedForm').style.display = 'block';
            document.querySelector('#addMedForm h3').innerText = 'Edit Medicine';
            document.getElementById('mName').value = med.name;
            document.getElementById('mBatch').value = med.batchNo || '';
            document.getElementById('mStock').value = med.stockQuantity;
            document.getElementById('mMinStock').value = med.minStockLevel;
            document.getElementById('mPrice').value = med.price;
            document.getElementById('mExpiry').value = med.expiryDate;
        }

        function closeMedForm() {
            document.getElementById('addMedForm').style.display = 'none';
        }

        function editMedicine(id) {
            const med = medicinesList.find(m => m.id === id);
            if (med) openEditForm(med);
        }

        async function fetchMedicines() {
            const res = await fetch('/api/medicines');
            const data = await res.json();
            medicinesList = data;
            const tbody = document.getElementById('medTableBody');
            
            if(data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="7" style="text-align: center;">No medicines found.</td></tr>';
                return;
            }

            tbody.innerHTML = '';
            data.forEach(med => {
                const isLow = med.stockQuantity <= med.minStockLevel;
                const isExpired = new Date(med.expiryDate) < new Date();
                
                let badge = '<span class="badge badge-success">Good</span>';
                if(isLow) badge = '<span class="badge badge-warning">Warning</span>';
                if(isExpired) badge = '<span class="badge badge-danger">Expired</span>';

                tbody.innerHTML += `
                    <tr>
                        <td>#\${med.id}</td>
                        <td style="font-weight: 500;">\${med.name}</td>
                        <td>\${med.batchNo || 'N/A'}</td>
                        <td>\${med.stockQuantity} \${isLow ? '<br><small style="color: var(--warning-color)">Low Stock</small>' : ''}</td>
                        <td>₹\${med.price.toFixed(2)}</td>
                        <td>\${med.expiryDate} \${isExpired ? '<br><small style="color: var(--danger-color)">Expired</small>' : ''}</td>
                        <td>\${badge}</td>
                        <td class="admin-only" style="display:none;">
                            <button class="btn-primary" style="padding: 0.3rem 0.6rem; font-size: 0.8rem; margin-right: 0.5rem;" onclick="editMedicine(\${med.id})">Edit</button>
                            <button class="btn-danger" style="padding: 0.3rem 0.6rem; font-size: 0.8rem;" onclick="deleteMedicine(\${med.id})">Delete</button>
                        </td>
                    </tr>
                `;
            });
            
            // Set styles after pushing elements
            setTimeout(() => {
                if(localStorage.getItem("role") === "ADMIN") {
                    document.getElementById("addMedBtn").style.display = "block";
                    document.querySelectorAll(".admin-only").forEach(el => el.style.display = "table-cell");
                }
            }, 50);
        }

        async function submitMedicine() {
            const payload = {
                name: document.getElementById('mName').value,
                batchNo: document.getElementById('mBatch').value,
                stockQuantity: parseInt(document.getElementById('mStock').value),
                minStockLevel: parseInt(document.getElementById('mMinStock').value),
                price: parseFloat(document.getElementById('mPrice').value),
                expiryDate: document.getElementById('mExpiry').value
            };
            
            if (editingId) {
                await fetch('/api/medicines/' + editingId, {
                    method: 'PUT',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(payload)
                });
            } else {
                await fetch('/api/medicines', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(payload)
                });
            }
            closeMedForm();
            fetchMedicines(); // Refresh
        }

        async function deleteMedicine(id) {
            if(!confirm("Are you sure you want to delete this medicine?")) return;
            await fetch('/api/medicines/' + id, { method: 'DELETE' });
            fetchMedicines();
        }

        fetchMedicines();
    </script>
</body>
</html>
