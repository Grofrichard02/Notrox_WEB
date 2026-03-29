const express = require("express");
const router = express.Router();
require("dotenv").config();
const multer = require("multer");
const path = require("path");
const fs = require("fs");
const Auth = require("./Auth.js");
const dbhandler = require("./dbhandler");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const auth = require("./Auth.js");

const sk = process.env.SECRET_KEY;
const expiresin = process.env.EXPIRES_IN;

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, './uploads/');
    },
    filename: function (req, file, cb) {
        cb(null, `profile-${req.uid}-${Date.now()}${path.extname(file.originalname).toLowerCase()}`);
    }
});

const fileFilter = (req, file, cb) => {
    const allowedMimeTypes = ['image/jpeg', 'image/png'];

    if (allowedMimeTypes.includes(file.mimetype)) {
        cb(null, true);
    } else {
        cb(new Error('LIMIT_FILE_TYPES'), false);
    }
};

const upload = multer({ 
    storage: storage,
    fileFilter: fileFilter,
    limits: { fileSize: 2 * 1024 * 1024 } 
});

router.get("/getMyAddresses", Auth(), async (req, res) => {
    try {
        const shipping = await dbhandler.Address.findOne({ 
            where: { UserId: req.uid } 
        });
        const billing = await dbhandler.BillingAddress.findOne({ 
            where: { UserId: req.uid } 
        });
        res.status(200).json({ shipping, billing });
    } catch (err) {
        console.error("Cím lekérési hiba:", err);
        res.status(500).json({ message: "Hiba történt a címek lekérésekor" });
    }
});

router.post("/UserLogin", async (req, res) => {
    try {
        const oneuser = await dbhandler.User.findOne({
            where: { Username: req.body.Username }
        });

        if (!oneuser) {
            return res.status(409).json({ message: "Nincs ilyen felhasználó" });
        }
        
        const match = await bcrypt.compare(req.body.Password, oneuser.Password);
        if (!match) {
            return res.status(401).json({ message: "Hibás felhasználónév vagy jelszó" });
        }

        const token = jwt.sign({ uid: oneuser.Id }, sk, { expiresIn: expiresin || "6h" });
        return res.status(200).json({ message: "Sikeres bejelentkezés", token });
    } catch (err) {
        return res.status(500).json({ message: "Szerver hiba" });
    }
});

router.post("/UserRegister", async (req, res) => {
    try {
        const oneuser = await dbhandler.User.findOne({ where: { Email: req.body.Email } });
        if (oneuser) return res.status(409).json({ message: "Van már ilyen felhasználó" });

        const hashedpassword = await bcrypt.hash(req.body.Password, 15);
        await dbhandler.User.create({
            Username: req.body.Username,
            Password: hashedpassword,
            Email: req.body.Email,
            Pfp: "/uploads/default-avatar.png"
        });
        return res.status(201).json({ message: "Sikeres regisztráció" });
    } catch (err) {
        console.log("HIBA VAN:");
        console.error(err);
        res.status(500).send("Szerver hiba");
    }
});

router.get("/getUser", auth(), async (req, res) => {
    try {
        const oneUser = await dbhandler.User.findOne({
            where: { Id: req.uid },
            attributes: { exclude: ["Password"] }
        });
        return res.status(200).json(oneUser);
    } catch (err) {
        return res.status(500).json({ message: "Szerver hiba" });
    }
});

router.get("/getAllUsers", auth(), async (req, res) => {
    try {
        const requester = await dbhandler.User.findOne({ where: { Id: req.uid } });

        if (!requester || requester.isAdmin !== true) {
            return res.status(403).json({ message: "Nincs admin jogosultságod!" });
        }
        const users = await dbhandler.User.findAll({
            attributes: ["Id", "Username", "Email", "Pfp", "isAdmin"]
        });

        console.log("Lekérdezés sikeres, userek száma:", users.length);
        return res.status(200).json(users);

    } catch (err) {
        console.error("HIBA a getAllUsers-nél:", err);
        return res.status(500).json({ message: "Szerver hiba történt a lekérdezés során" });
    }
});

router.get("/getUserAddresses/:id", auth(), async (req, res) => {
    try {
        const admin = await dbhandler.User.findOne({ where: { Id: req.uid } });
        if (!admin || !admin.isAdmin) return res.status(403).send("Nincs jogosultság");

        const shipping = await dbhandler.Address.findAll({ where: { UserId: req.params.id } });
        const billing = await dbhandler.BillingAddress.findAll({ where: { UserId: req.params.id } });

        res.status(200).json({ shipping, billing });
    } catch (err) {
        res.status(500).json({ message: "Hiba a címek lekérésekor" });
    }
});

router.delete("/deleteUser/:id", auth(), async (req, res) => {
    try {
        const requesterId = req.uid; 
        const targetId = req.params.id; 
        const requester = await dbhandler.User.findOne({ where: { Id: requesterId } });
        if (requester.isAdmin || requesterId == targetId) {
            
            await dbhandler.User.destroy({ where: { Id: targetId } });
            return res.status(200).json({ message: "Sikeres törlés" });
            
        } else {
            return res.status(403).json({ message: "Nincs jogosultságod más felhasználót törölni!" });
        }
    } catch (err) {
        console.error(err);
        return res.status(500).json({ message: "Szerver hiba történt a törlés során." });
    }
});

router.put("/EditUser", auth(), async (req, res) => {
    try {
        const Id = req.uid;
        
        const oneuser = await dbhandler.User.findOne({ 
            where: { Id },
            attributes: ["Id", "Password"]
        });

        if (!oneuser) {
            return res.status(404).json({ message: "Felhasználó nem található" });
        }

        const updateData = {};

        if (req.body.Password || req.body.OldPassword) {
            
            if (!req.body.OldPassword) {
                return res.status(400).json({ message: "A jelszó módosításához kötelező megadni a régi jelszót!" });
            }

            const isMatch = await bcrypt.compare(req.body.OldPassword, oneuser.Password);
            
            if (!isMatch) {
                return res.status(401).json({ message: "A megadott régi jelszó hibás! A módosítás elutasítva." });
            }
            if(isMatch){
                updateData.Password = await bcrypt.hash(req.body.Password, 15);
            
            }

        }

        if (req.body.Username) updateData.Username = req.body.Username;
        if (req.body.Email) updateData.Email = req.body.Email;

        if (Object.keys(updateData).length === 0) {
            return res.status(400).json({ message: "Nincs módosítandó adat." });
        }

        await dbhandler.User.update(updateData, { where: { Id } });
        return res.status(200).json({ message: "Sikeres adatmódosítás!" });

    } catch (err) {
        console.error("EDIT USER ERROR:", err);
        return res.status(500).json({ message: "Hiba történt a szerveren." });
    }
});

router.post("/UploadProfilePic", auth(), (req, res) => {
    upload.single('profileImage')(req, res, async (err) => {
        if (err) {
            if (err.message === 'LIMIT_FILE_TYPES') {
                return res.status(400).json({ message: "Csak JPG, JPEG és PNG fájlok engedélyezettek!" });
            }
            return res.status(400).json({ message: "Feltöltési hiba: " + err.message });
        }

        try {
            if (!req.file) return res.status(400).json({ message: "Nem érkezett fájl" });

            const filePath = `/uploads/${req.file.filename}`;
            await dbhandler.User.update({ Pfp: filePath }, { where: { Id: req.uid } });
            
            return res.status(200).json({ message: "Sikeres képfeltöltés", Pfp: filePath });
        } catch (err) {
            return res.status(500).json({ message: "Szerver hiba" });
        }
    });
});

module.exports = router;
