<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartPharma - Login</title>
    <link rel="stylesheet" href="/css/style.css">
    <script>
        async function handleLogin(e) {
            e.preventDefault();
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const errorDiv = document.getElementById('error');
            
            try {
                const response = await fetch('/api/auth/login', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ username, password })
                });
                
                if (response.ok) {
                    const data = await response.json();
                    localStorage.setItem('userId', data.id);
                    localStorage.setItem('role', data.role);
                    window.location.href = '/dashboard';
                } else {
                    errorDiv.style.display = 'block';
                    errorDiv.innerText = 'Invalid credentials';
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
          <svg style="color: var(--primary-color);" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m10.5 20.5 10-10a4.95 4.95 0 1 0-7-7l-10 10a4.95 4.95 0 1 0 7 7Z"/><path d="m8.5 8.5 7 7"/></svg>
          <h2 class="heading-large" style="font-size: 1.8rem; margin-top: 1rem;">SmartPharma</h2>
          <p class="text-muted">Enter your credentials to access the system</p>
        </div>
        
        <div id="error" style="display: none; color: #ff4757; margin-bottom: 1rem; text-align: center; background: rgba(255, 71, 87, 0.1); padding: 0.5rem; border-radius: 8px;"></div>
        
        <form onsubmit="handleLogin(event)">
          <div class="form-group">
            <label class="form-label">Username</label>
            <input type="text" id="username" class="glass-input" required />
          </div>
          <div class="form-group">
            <label class="form-label">Password</label>
            <input type="password" id="password" class="glass-input" required />
          </div>
          <button type="submit" class="btn-primary" style="margin-top: 1rem;">Sign In</button>
        </form>

        <div style="text-align: center; margin-top: 1.5rem;">
            <a href="/signup" style="color: var(--primary-color); text-decoration: none; font-size: 0.95rem;">Don't have an account? Sign up here</a>
        </div>
      </div>
    </div>
</body>
</html>
