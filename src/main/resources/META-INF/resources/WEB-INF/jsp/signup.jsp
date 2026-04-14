<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartPharma - Sign Up</title>
    <link rel="stylesheet" href="/css/style.css">
    <script>
        async function handleSignup(e) {
            e.preventDefault();
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const role = document.getElementById('role').value;
            const errorDiv = document.getElementById('error');
            
            try {
                const response = await fetch('/api/auth/register', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ username, password, role })
                });
                
                if (response.ok) {
                    alert('Registration successful! Please login.');
                    window.location.href = '/login';
                } else {
                    const errorMsg = await response.text();
                    errorDiv.style.display = 'block';
                    errorDiv.innerText = errorMsg || 'Registration failed';
                }
            } catch (err) {
                console.error(err);
            }
        }
    </script>
</head>
<body>
    <div style="display: flex; justify-content: center; alignItems: center; min-height: 100vh; width: 100%; align-items: center;">
      <div class="glass-panel" style="width: 100%; max-width: 400px;">
        <div style="text-align: center; margin-bottom: 2rem;">
          <!-- SVG Icon -->
          <svg style="color: var(--primary-color);" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><line x1="19" y1="8" x2="19" y2="14"/><line x1="22" y1="11" x2="16" y2="11"/></svg>
          <h2 class="heading-large" style="font-size: 1.8rem; margin-top: 1rem;">Create Account</h2>
          <p class="text-muted">Sign up to access SmartPharma</p>
        </div>
        
        <div id="error" style="display: none; color: #ff4757; margin-bottom: 1rem; text-align: center; background: rgba(255, 71, 87, 0.1); padding: 0.5rem; border-radius: 8px;"></div>
        
        <form onsubmit="handleSignup(event)">
          <div class="form-group">
            <label class="form-label">Username</label>
            <input type="text" id="username" class="glass-input" required />
          </div>
          <div class="form-group">
            <label class="form-label">Password</label>
            <input type="password" id="password" class="glass-input" required />
          </div>
          <div class="form-group">
            <label class="form-label">Role</label>
            <select id="role" class="glass-input" required>
                <option value="STAFF">Staff</option>
                <option value="ADMIN">Admin</option>
            </select>
          </div>
          <button type="submit" class="btn-primary" style="margin-top: 1rem;">Register</button>
        </form>
        
        <div style="text-align: center; margin-top: 1.5rem;">
            <a href="/login" style="color: var(--primary-color); text-decoration: none; font-size: 0.95rem;">Already have an account? Login here</a>
        </div>
      </div>
    </div>
</body>
</html>
