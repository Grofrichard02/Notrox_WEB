let allOrders = [];

document.addEventListener("DOMContentLoaded", fetchOrders);

async function fetchOrders() {
    const token = sessionStorage.getItem('token');
    const container = document.getElementById('orderListContainer');
    try {
        const response = await fetch('/getAllOrders', {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (!response.ok) throw new Error("Hiba a letöltéskor");
        allOrders = await response.json();
        allOrders.sort((a, b) => b.Id - a.Id);
        renderOrders();
    } catch (err) {
        container.innerHTML = `<p class="text-danger text-center py-5">Hiba a rendelések betöltésekor.</p>`;
    }
}

function renderOrders() {
    const container = document.getElementById('orderListContainer');
    if (allOrders.length === 0) {
        container.innerHTML = "<div class='text-center py-5 text-secondary'>Nincs rögzített rendelés.</div>";
        return;
    }
    container.innerHTML = allOrders.map(order => {
        const total = order.OrderItems ? order.OrderItems.reduce((sum, item) => sum + (item.PriceAtPurchase * item.Quantity), 0) : 0;
        const orderDate = new Date(order.Date).toLocaleString('hu-HU', { 
            year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit' 
        });
        return `
            <div class="order-row" id="row-${order.Id}">
                <div class="col-id" data-label="Rendelésszám">#${order.Id}</div>
                <div class="col-date" data-label="Dátum">${orderDate}</div>
                <div class="col-price" data-label="Összeg">${total.toLocaleString()} Ft</div>
                <div class="col-phase" data-label="Státusz" id="phase-container-${order.Id}">
                    <span class="phase-badge">${order.Phase}</span>
                </div>
                <div class="col-actions" id="action-container-${order.Id}">
                    <i class="fa-solid fa-pencil action-icon" onclick="enablePhaseEdit(${order.Id}, '${order.Phase}')"></i>
                </div>
            </div>
        `;
    }).join('');
}

function enablePhaseEdit(id, currentPhase) {
    const phases = ["Feldolgozás alatt", "Összekészítés alatt", "Csomagolás kész", "Átadva futárnak", "Kiszállítás alatt", "Kiszállítva", "Törölve"];
    const container = document.getElementById(`phase-container-${id}`);
    const actionContainer = document.getElementById(`action-container-${id}`);
    let selectHtml = `<select class="edit-select" id="select-${id}">`;
    phases.forEach(p => {
        selectHtml += `<option value="${p}" ${p === currentPhase ? 'selected' : ''}>${p}</option>`;
    });
    selectHtml += `</select>`;
    container.innerHTML = selectHtml;
    actionContainer.innerHTML = `<i class="fa-solid fa-check action-icon" style="color:#22c55e" onclick="savePhase(${id})"></i>`;
}

async function savePhase(id) {
    const newPhase = document.getElementById(`select-${id}`).value;
    const token = sessionStorage.getItem('token');
    try {
        const response = await fetch(`/updateOrderPhase/${id}`, {
            method: 'PUT',
            headers: { 
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            body: JSON.stringify({ Phase: newPhase })
        });
        if (response.ok) {
            const order = allOrders.find(o => o.Id === id);
            order.Phase = newPhase;
            renderOrders();
        } else {
            alert("Hiba a mentés során!");
        }
    } catch (err) {
        console.error("Hálózati hiba:", err);
    }
}

function goToProductAdd() { window.location.href = "product-add"; }
function goToUser() { window.location.href = "adminpanel"; }
function goToListProd() { window.location.href = "product-list"; }

function logout() {
    sessionStorage.clear();
    localStorage.removeItem('token');
    alert("Sikeres kijelentkezés!");
    window.location.replace("admin"); 
}