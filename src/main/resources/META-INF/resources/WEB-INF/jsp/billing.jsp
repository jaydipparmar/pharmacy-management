<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SmartPharma - Billing</title>
    <link rel="stylesheet" href="/css/style.css">
    <script>
        let medicines = [];
        let cart = [];
        
        async function fetchMedicines() {
            const res = await fetch('/api/medicines');
            medicines = await res.json();
            renderMedicines();
        }

        function renderMedicines() {
            const grid = document.getElementById('medGrid');
            grid.innerHTML = '';
            medicines.forEach(med => {
                const isAvailable = med.stockQuantity > 0;
                grid.innerHTML += `
                    <div class="glass-panel" style="padding: 1.5rem; cursor: \${isAvailable ? 'pointer' : 'not-allowed'}; opacity: \${isAvailable ? 1 : 0.5}"
                         onclick="\${isAvailable ? 'addToCart(' + med.id + ')' : ''}">
                        <h3 style="margin-bottom: 0.5rem;">\${med.name}</h3>
                        <div class="flex-between text-muted">
                            <span>Stock: \${med.stockQuantity}</span>
                            <span style="color: var(--success-color); font-weight: bold;">₹\${med.price.toFixed(2)}</span>
                        </div>
                    </div>
                `;
            });
        }

        function addToCart(id) {
            const med = medicines.find(m => m.id === id);
            const existing = cart.find(c => c.medicine.id === id);
            if(existing) {
                existing.quantity += 1;
            } else {
                cart.push({ medicine: med, quantity: 1, price: med.price });
            }
            renderCart();
        }

        function renderCart() {
            const cartDiv = document.getElementById('cartItems');
            cartDiv.innerHTML = '';
            let total = 0;
            
            if(cart.length === 0) {
                cartDiv.innerHTML = '<p class="text-muted" style="text-align: center;">Cart is empty</p>';
            } else {
                cart.forEach((item, idx) => {
                    const lineTotal = item.quantity * item.price;
                    total += lineTotal;
                    cartDiv.innerHTML += `
                        <div class="flex-between" style="margin-bottom: 1rem;">
                            <div>
                                <div style="font-weight: 500;">\${item.medicine.name}</div>
                                <div class="text-muted" style="font-size: 0.85rem;">Qty: \${item.quantity} x ₹\${item.price.toFixed(2)}</div>
                            </div>
                            <div>₹\${lineTotal.toFixed(2)}</div>
                        </div>
                    `;
                });
            }
            
            document.getElementById('totalAmt').innerText = '₹' + total.toFixed(2);
            document.getElementById('btnComplete').disabled = cart.length === 0;
        }

        async function completeSale() {
            if(cart.length === 0) return;
            const payload = {
                user: { id: localStorage.getItem('userId') },
                items: cart.map(c => ({ medicine: { id: c.medicine.id }, quantity: c.quantity }))
            };
            
            try {
                const res = await fetch('/api/sales', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(payload)
                });
                if(res.ok) {
                    const saleData = await res.json();
                    
                    let receiptHtml = `
                        <div style="font-family: 'Courier New', Courier, monospace; padding: 20px; max-width: 400px; margin: 0 auto; border: 1px dashed #ccc;">
                            <h2 style="text-align: center; color: #10ac84; margin-bottom: 5px;">SmartPharma</h2>
                            <p style="text-align: center; font-size: 12px; color: #666; margin-top: 0;">123 Healthcare Ave, Wellness City</p>
                            <hr style="border-top: 1px dashed #ccc; margin: 15px 0;">
                            <p style="margin: 5px 0;"><strong>Receipt #:</strong> \${saleData.id || Math.floor(Math.random() * 100000)}</p>
                            <p style="margin: 5px 0;"><strong>Date:</strong> \${new Date().toLocaleString()}</p>
                            <hr style="border-top: 1px dashed #ccc; margin: 15px 0;">
                            <table style="width: 100%; font-size: 14px; text-align: left; border-collapse: collapse;">
                                <tr>
                                    <th style="padding-bottom: 5px; border-bottom: 1px solid #eee;">Item</th>
                                    <th style="text-align: right; padding-bottom: 5px; border-bottom: 1px solid #eee;">Qty</th>
                                    <th style="text-align: right; padding-bottom: 5px; border-bottom: 1px solid #eee;">Amt</th>
                                </tr>
                    `;
                    
                    let totalVal = 0;
                    cart.forEach(item => {
                        const line = item.quantity * item.price;
                        totalVal += line;
                        receiptHtml += `
                            <tr>
                                <td style="padding: 5px 0;">\${item.medicine.name}</td>
                                <td style="text-align: right;">\${item.quantity}</td>
                                <td style="text-align: right;">₹\${line.toFixed(2)}</td>
                            </tr>
                        `;
                    });
                    
                    receiptHtml += `
                            </table>
                            <hr style="border-top: 1px dashed #ccc; margin: 15px 0;">
                            <div style="display: flex; justify-content: space-between; font-weight: bold; font-size: 18px;">
                                <span>TOTAL</span>
                                <span>₹\${totalVal.toFixed(2)}</span>
                            </div>
                            <p style="text-align: center; margin-top: 30px; font-size: 12px; color: #555;">Thank you for your purchase!</p>
                        </div>
                    `;
                    
                    const printWindow = window.open('', '_blank', 'width=500,height=600');
                    printWindow.document.write('<html><head><title>Print Receipt</title></head><body>' + receiptHtml + '</body></html>');
                    printWindow.document.close();
                    printWindow.focus();
                    setTimeout(() => { printWindow.print(); printWindow.close(); }, 500);

                    cart = [];
                    renderCart();
                    fetchMedicines(); // update stock
                } else {
                    alert('Error generating sale');
                }
            } catch(e) { console.error(e); }
        }

        window.onload = function() { fetchMedicines(); renderCart(); };
    </script>
</head>
<body>
    <div class="app-container">
        <jsp:include page="sidebar.jsp" />
        
        <main class="main-content" style="display: flex; gap: 2rem;">
            <div style="flex: 2;">
                <h1 class="heading-large">Point of Sale</h1>
                <p class="text-muted" style="margin-bottom: 2rem;">Select medicines to add to the cart</p>
                <div id="medGrid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 1rem;">
                </div>
            </div>

            <div style="flex: 1;">
                <div class="glass-panel" style="position: sticky; top: 2rem;">
                    <div class="flex-between" style="margin-bottom: 1.5rem; border-bottom: 1px solid var(--glass-border); padding-bottom: 1rem;">
                        <h3>Current Cart</h3>
                    </div>
                    <div id="cartItems" style="min-height: 200px; max-height: 400px; overflow-y: auto;">
                    </div>
                    <div style="margin-top: 2rem; border-top: 1px solid var(--glass-border); padding-top: 1rem;">
                        <div class="flex-between" style="margin-bottom: 1.5rem; font-size: 1.2rem; font-weight: bold; color: var(--text-primary);">
                            <span>Total:</span>
                            <span id="totalAmt">₹0.00</span>
                        </div>
                        <button id="btnComplete" class="btn-primary" onclick="completeSale()" disabled>Complete Sale</button>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
