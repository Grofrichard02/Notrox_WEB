const express = require("express");
const router = express.Router();
const dbhandler = require("./dbhandler");
const Auth = require("./Auth.js");

router.post("/createOrder", Auth(), async (req, res) => {
    try {
        const { cart, AddressId } = req.body;
        const UserId = req.uid;

        if (!cart || cart.length === 0) return res.status(400).json({ message: "Üres a kosár" });
        if (!AddressId) return res.status(400).json({ message: "Hiányzó cím azonosító" });
        const newOrder = await dbhandler.Order.create({
            UserId: UserId,
            AddressId: AddressId,
            Date: new Date(),
            Phase: "Feldolgozás alatt"
        });
        for (const item of cart) {
            await dbhandler.OrderItem.create({
                OrderId: newOrder.Id,
                ProductId: item.Id,
                Quantity: item.quantity,
                PriceAtPurchase: item.Price
            });
            const product = await dbhandler.Products.findByPk(item.Id);
            if (product) {
                const currentStock = product.Ammount || 0;
                const newStock = currentStock - item.quantity;
                await product.update({ Ammount: newStock > 0 ? newStock : 0 });
            }
        }
        return res.status(201).json({ 
            message: "Rendelés sikeres!", 
            orderId: newOrder.Id 
        });

    } catch (err) {
        console.error("!!! RENDELÉSI HIBA A BACKENDEN:", err);
        return res.status(500).json({ 
            message: "Szerver hiba a rendelés során", 
            error: err.message 
        });
    }
});
router.get("/getMyOrders", Auth(), async (req, res) => {
    try {
        if (!dbhandler.Order || !dbhandler.OrderItem || !dbhandler.Products) {
            return res.status(500).json({ message: "Adatbázis konfigurációs hiba" });
        }

        const orders = await dbhandler.Order.findAll({
            where: { UserId: req.uid },
            include: [
                {
                    model: dbhandler.OrderItem,
                    include: [{
                        model: dbhandler.Products 
                    }]
                },
                {
                    model: dbhandler.Address 
                }
            ],
            order: [['Date', 'DESC']]
        });
        res.status(200).json(orders);

    } catch (err) {
        console.error("!!! RENDELÉSI LISTA HIBA:", err.message);
        res.status(500).json({ message: "Hiba a rendelések lekérésekor", error: err.message });
    }
});

router.get("/getAllOrders", Auth(), async (req, res) => {
    try {
        const user = await dbhandler.User.findByPk(req.uid);
        if (!user || !user.isAdmin) return res.status(403).json({ message: "Nincs jogosultság" });

        const orders = await dbhandler.Order.findAll({
            include: [{ model: dbhandler.OrderItem }],
            order: [['Id', 'ASC']] 
        });
        res.status(200).json(orders);
    } catch (err) {
        res.status(500).json({ message: "Hiba a lekéréskor" });
    }
});

router.put("/updateOrderPhase/:id", Auth(), async (req, res) => {
    try {
        const user = await dbhandler.User.findByPk(req.uid);
        if (!user || !user.isAdmin) return res.status(403).json({ message: "Nincs jogosultság" });

        await dbhandler.Order.update(
            { Phase: req.body.Phase },
            { where: { Id: req.params.id } }
        );
        res.status(200).json({ message: "Státusz frissítve" });
    } catch (err) {
        res.status(500).json({ message: "Hiba a frissítéskor" });
    }
});
module.exports = router;