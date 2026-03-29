let allProducts = [];
let deleteId = null;

async function loadProducts() {
    try {
        const res = await fetch('/getproduct');
        allProducts = await res.json();
        renderProducts(allProducts);
    } catch (err) {
        console.error("Hiba:", err);
        document.getElementById('productList').innerHTML = "Hiba a termékek betöltésekor.";
    }
}

function renderProducts(products) {
    const list = document.getElementById('productList');
    list.innerHTML = "";

    if (products.length === 0) {
        list.innerHTML = "<p style='text-align:center; color:gray;'>Nincs találat.</p>";
        return;
    }

    products.forEach(p => {
        const brandName = p.Company ? p.Company.Name : "Ismeretlen";

        const item = document.createElement('div');
        item.className = 'product-item';
        item.id = `product-${p.Id}`;
        item.innerHTML = `
            <img src="${p.IMGURL}" class="p-img-sm" id="img-${p.Id}" onerror="this.src='/uploads/default-avatar.png'">

            <div class="p-info-container">
                <div class="p-top-row">
                    <span class="p-name" id="name-${p.Id}">${p.Name}</span>
                    <span class="p-brand">${brandName}</span>
                </div>
                <div class="p-desc" id="desc-${p.Id}">${p.Description}</div>
                
                <div class="p-stats-row">
                    <span class="p-price"><span id="price-${p.Id}">${p.Price}</span> Ft</span>
                    <span class="p-amount"><span id="amount-${p.Id}">${p.Ammount}</span> db</span>
                </div>
            </div>

            <div class="p-actions">
                <i class="fa-solid fa-pencil" id="edit-btn-${p.Id}" title="Szerkesztés" onclick="enableEdit(${p.Id})"></i>
                <i class="fa-solid fa-check" id="save-btn-${p.Id}" title="Mentés" onclick="saveEdit(${p.Id})" style="display:none; color: #22c55e;"></i>
                <i class="fa-solid fa-trash" title="Törlés" onclick="askDelete(${p.Id}, '${p.Name}')"></i>
            </div>
        `;
        list.appendChild(item);
    });
}

function enableEdit(id) {
    const fields = ['name', 'desc', 'price', 'amount'];
    fields.forEach(f => {
        const el = document.getElementById(`${f}-${id}`);
        const val = el.innerText.replace(' Ft', '').replace(' db', '');
        el.innerHTML = `<input type="${f === 'price' || f === 'amount' ? 'number' : 'text'}" class="edit-input" id="input-${f}-${id}" value="${val}">`;
    });

    const imgEl = document.getElementById(`img-${id}`);
    const currentImg = imgEl.src;
    const imgInput = document.createElement('input');
    imgInput.className = 'edit-input';
    imgInput.placeholder = "Kép URL...";
    imgInput.id = `input-img-${id}`;
    imgInput.value = currentImg;
    
    // Mobilon jobb, ha az információs konténerbe tesszük az inputot szerkesztéskor
    const infoContainer = imgEl.nextElementSibling;
    infoContainer.prepend(imgInput);
    imgEl.style.display = "none";

    document.getElementById(`edit-btn-${id}`).style.display = "none";
    document.getElementById(`save-btn-${id}`).style.display = "inline-block";
}

async function saveEdit(id) {
    const token = sessionStorage.getItem('token');
    const updatedData = {
        Name: document.getElementById(`input-name-${id}`).value,
        Description: document.getElementById(`input-desc-${id}`).value,
        Price: parseInt(document.getElementById(`input-price-${id}`).value),
        Ammount: parseInt(document.getElementById(`input-amount-${id}`).value),
        IMGURL: document.getElementById(`input-img-${id}`).value
    };

    try {
        const res = await fetch(`/updateproduct/${id}`, {
            method: 'PUT',
            headers: { 
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            body: JSON.stringify(updatedData)
        });

        if (res.ok) {
            loadProducts();
        } else {
            alert("Hiba a mentés során!");
        }
    } catch (err) {
        console.error(err);
    }
}

function askDelete(id, name) {
    deleteId = id;
    document.getElementById('deleteTargetName').innerText = name;
    document.getElementById('deleteModal').style.display = 'block';
}

document.getElementById('confirmDeleteBtn').onclick = async () => {
    const token = sessionStorage.getItem('token');
    try {
        const res = await fetch(`/deleteproduct/${deleteId}`, {
            method: 'DELETE',
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (res.ok) {
            closeModal();
            loadProducts();
        }
    } catch (err) {
        console.error(err);
    }
};

function closeModal() {
    document.getElementById('deleteModal').style.display = 'none';
    deleteId = null;
}

function filterProducts() {
    const term = document.getElementById('pSearch').value.toLowerCase();
    const filtered = allProducts.filter(p => 
        p.Name.toLowerCase().includes(term) || 
        (p.Company && p.Company.Name.toLowerCase().includes(term))
    );
    renderProducts(filtered);
}

// Navigáció
function goToProductAdd() { window.location.href = "product-add"; }
function goToGetUsers() { window.location.href = "adminpanel"; }
function goToOrder() { window.location.href = "order-list"; }

function logout() {
    sessionStorage.clear();
    localStorage.removeItem('token');
    window.location.replace("admin");
}

loadProducts();