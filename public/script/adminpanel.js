let allUsers = [];
let userToDeleteId = null;

async function init() {
    const token = sessionStorage.getItem('token');
    if (!token) { window.location.href = "404.html"; return; }

    try {
        const check = await fetch('/getUser', {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        const me = await check.json();
        if (!me.isAdmin) { window.location.href = "404.html"; return; }

        await loadAllUsers();
    } catch (err) {
        document.getElementById('userList').innerHTML = `<p style="color:red; text-align:center;">Hálózat hiba vagy 504 Timeout</p>`;
    }
}

async function loadAllUsers() {
    const token = sessionStorage.getItem('token');
    const res = await fetch('/getAllUsers', {
        headers: { 'Authorization': `Bearer ${token}` }
    });

    if (res.ok) {
        allUsers = await res.json();
        render(allUsers);
    } else {
        document.getElementById('userList').innerHTML = `<p style="color:red; text-align:center;">Hiba: ${res.status}</p>`;
    }
}

function render(users) {
    const container = document.getElementById('userList');
    container.innerHTML = "";

    if (users.length === 0) {
        container.innerHTML = "<p class='no-result'>Nincs találat.</p>";
        return;
    }

    users.forEach(u => {
        const card = document.createElement('div');
        card.className = 'user-card';
        card.innerHTML = `
            <img src="${u.Pfp || '/uploads/default-avatar.png'}" class="user-pfp">
            <div class="user-info-block">
                <div class="username-row">
                    <span class="username">${u.Username}</span>
                    <span class="role-badge ${u.isAdmin ? 'admin-badge' : 'user-badge'}">
                        ${u.isAdmin ? 'Admin' : 'User'}
                    </span>
                </div>
                <div class="user-email">${u.Email}</div>
                <div class="user-id">ID: #${u.Id}</div>
                <div class="user-actions">
                    <i class="fa-solid fa-house" onclick="openAddressModal(${u.Id}, '${u.Username}')" title="Címek"></i>
                    <i class="fa-solid fa-trash" onclick="openDeleteModal(${u.Id}, '${u.Username}')" title="Törlés"></i>
                </div>
            </div>
        `;
        container.appendChild(card);
    });
}

async function openAddressModal(id, name) {
    const token = sessionStorage.getItem('token');
    const modal = document.getElementById('addressModal').style.display = 'flex';
    const shipList = document.getElementById('shippingList');
    const billList = document.getElementById('billingList');
    
    document.getElementById('addrTitle').innerText = `${name} címei`;
    shipList.innerHTML = "Betöltés...";
    billList.innerHTML = "Betöltés...";

    try {
        const res = await fetch(`/getUserAddresses/${id}`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        const data = await res.json();

        shipList.innerHTML = data.shipping.length > 0 
            ? data.shipping.map(a => `<div class="addr-item">${a.Zip} ${a.City}, ${a.Address1}</div>`).join('')
            : "<span class='no-addr-text'>Nincs megadva.</span>";

        billList.innerHTML = data.billing.length > 0 
            ? data.billing.map(a => `<div class="addr-item">${a.Zip} ${a.City}, ${a.Address1}</div>`).join('')
            : "<span class='no-addr-text'>Nincs megadva.</span>";
    } catch (err) {
        shipList.innerHTML = "Hiba az adatok lekérésekor.";
    }
}

function openDeleteModal(id, name) {
    userToDeleteId = id;
    document.getElementById('deleteUserName').innerText = name;
    document.getElementById('deleteConfirmInput').value = "";
    document.getElementById('confirmDeleteBtn').disabled = true;
    document.getElementById('deleteModal').style.display = 'flex';
}

document.getElementById('deleteConfirmInput').addEventListener('input', function(e) {
    document.getElementById('confirmDeleteBtn').disabled = (e.target.value !== "DELETE");
});

document.getElementById('confirmDeleteBtn').onclick = async function() {
    if (!userToDeleteId) return;
    const token = sessionStorage.getItem('token');
    try {
        const res = await fetch(`/deleteUser/${userToDeleteId}`, {
            method: 'DELETE',
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (res.ok) {
            closeModal('deleteModal');
            loadAllUsers();
        } else {
            const error = await res.json();
            alert("Hiba: " + error.message);
        }
    } catch (err) {
        alert("Szerver hiba.");
    }
};

function closeModal(modalId) {
    document.getElementById(modalId).style.display = 'none';
}

function filterUsers() {
    const term = document.getElementById('userSearch').value.toLowerCase().trim();
    const filtered = allUsers.filter(u => 
        u.Username.toLowerCase().includes(term) || u.Email.toLowerCase().includes(term)
    );
    render(filtered);
}

// Navigációs függvények
function goToProductAdd() { window.location.href = "product-add"; }
function goToOrder() { window.location.href = "order-list"; }
function goToListProd() { window.location.href = "product-list"; }

function logout() {
    sessionStorage.clear();
    localStorage.removeItem('token');
    alert("Sikeres kijelentkezés!");
    window.location.replace("admin"); 
}

window.onclick = function(event) {
    if (event.target.className === 'modal') {
        event.target.style.display = "none";
    }
}

init();