<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SmartPharma - Suppliers</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="app-container">
        <jsp:include page="sidebar.jsp" />
        
        <main class="main-content">
            <div class="topbar">
                <div>
                    <h1 class="heading-large">Suppliers Directory</h1>
                    <p class="text-muted">Manage your supplier contacts and records</p>
                </div>
                <button id="addSupBtn" class="btn-primary" style="width: auto; display: none;" onclick="document.getElementById('addSupForm').style.display='block'">+ Add Supplier</button>
            </div>

            <div id="addSupForm" class="glass-panel" style="display: none; margin-bottom: 2rem;">
                <h3>Add New Supplier</h3>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-top: 1rem;">
                    <input type="text" id="sName" placeholder="Supplier Name" class="glass-input">
                    <input type="text" id="sContact" placeholder="Contact Number" class="glass-input">
                    <input type="email" id="sEmail" placeholder="Email" class="glass-input">
                    <input type="text" id="sAddress" placeholder="Address" class="glass-input">
                </div>
                <div style="margin-top: 1rem;">
                    <button class="btn-primary" style="width: auto;" onclick="addSupplier()">Save</button>
                    <button class="btn-danger" style="width: auto; margin-left: 1rem;" onclick="document.getElementById('addSupForm').style.display='none'">Cancel</button>
                </div>
            </div>

            <div class="glass-panel" style="padding: 0; overflow: hidden;">
                <table class="glass-table">
                    <thead>
                        <tr>
                            <th>ID</th><th>Name</th><th>Contact Number</th><th>Email</th><th>Address</th><th class="admin-only" style="display:none;">Action</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                    </tbody>
                </table>
            </div>
        </main>
    </div>

    <script>
        async function fetchSuppliers() {
            const res = await fetch('/api/suppliers');
            const data = await res.json();
            const tbody = document.getElementById('tableBody');
            
            if(data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="5" style="text-align: center;">No suppliers found.</td></tr>';
                return;
            }

            tbody.innerHTML = '';
            data.forEach(s => {
                tbody.innerHTML += `
                    <tr>
                        <td>#\${s.id}</td>
                        <td style="font-weight: 500;">\${s.name}</td>
                        <td>\${s.contactNumber || ''}</td>
                        <td>\${s.email || ''}</td>
                        <td>\${s.address || ''}</td>
                        <td class="admin-only" style="display:none;">
                            <button class="btn-danger" style="padding: 0.3rem 0.6rem; font-size: 0.8rem;" onclick="deleteSupplier(\${s.id})">Delete</button>
                        </td>
                    </tr>
                `;
            });
            
            setTimeout(() => {
                if(localStorage.getItem("role") === "ADMIN") {
                    document.getElementById("addSupBtn").style.display = "block";
                    document.querySelectorAll(".admin-only").forEach(el => el.style.display = "table-cell");
                }
            }, 50);
        }

        async function addSupplier() {
            const payload = {
                name: document.getElementById('sName').value,
                contactNumber: document.getElementById('sContact').value,
                email: document.getElementById('sEmail').value,
                address: document.getElementById('sAddress').value
            };
            
            await fetch('/api/suppliers', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            });
            document.getElementById('addSupForm').style.display = 'none';
            fetchSuppliers(); 
        }

        async function deleteSupplier(id) {
            if(!confirm("Are you sure you want to delete this supplier?")) return;
            await fetch('/api/suppliers/' + id, { method: 'DELETE' });
            fetchSuppliers();
        }

        fetchSuppliers();
    </script>
</body>
</html>
