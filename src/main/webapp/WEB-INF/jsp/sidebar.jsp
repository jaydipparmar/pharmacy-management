<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<aside class="sidebar">
  <div class="sidebar-brand">
    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m10.5 20.5 10-10a4.95 4.95 0 1 0-7-7l-10 10a4.95 4.95 0 1 0 7 7Z"/><path d="m8.5 8.5 7 7"/></svg>
    SmartPharma
  </div>
  
  <nav style="flex: 1;">
    <a href="/dashboard" class="nav-item" id="nav-dashboard">
      Dashboard
    </a>
    <a href="/inventory" class="nav-item" id="nav-inventory">
      Inventory
    </a>
    <a href="/billing" class="nav-item" id="nav-billing">
      Billing / Sale
    </a>
    <a href="/suppliers" class="nav-item" id="nav-suppliers">
      Suppliers
    </a>
  </nav>
  
  <button onclick="handleLogout()" class="nav-item" style="background: transparent; border: none; cursor: pointer; width: 100%; text-align: left;">
    <span style="color: var(--danger-color); font-weight: 500;">Logout</span>
  </button>
</aside>

<script>
  function handleLogout() {
    localStorage.removeItem("userId");
    localStorage.removeItem("role");
    window.location.href = "/login";
  }

  // Highlight active nav
  const currentPath = window.location.pathname;
  if(currentPath.includes("dashboard")) document.getElementById("nav-dashboard").classList.add("active");
  if(currentPath.includes("inventory")) document.getElementById("nav-inventory").classList.add("active");
  if(currentPath.includes("billing")) document.getElementById("nav-billing").classList.add("active");
  if(currentPath.includes("suppliers")) document.getElementById("nav-suppliers").classList.add("active");

  // Auth check
  if(!localStorage.getItem("userId") && currentPath !== "/login") {
      window.location.href = "/login";
  }
</script>
