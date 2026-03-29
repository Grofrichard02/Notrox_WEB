const request = require("supertest")
const app = require("./server")
const dbhandler = require("./dbhandler")
const bcrypt = require("bcrypt")
const jwt = require("jsonwebtoken")
describe("User API", () => {

  // User Tests
  describe("POST /UserLogin", () => {
    let validToken
    let userId

    beforeAll(async () => {
      const hashedPassword = await bcrypt.hash('password123', 10)
      const user = await dbhandler.User.create({
        Username: "testuser",
        Password: hashedPassword,
        Email: "testuser@example.com",
      })

      userId = user.Id

      validToken = jwt.sign({ uid: user.Id }, process.env.SECRET_KEY, { expiresIn: '1h' })
    })

    it("should return 200 if the user successfully logs in", async () => {
      const res = await request(app)
        .post("/UserLogin")
        .send({ Username: "testuser", Password: "password123" })

      expect(res.status).toBe(200)
      expect(res.body).toHaveProperty("token")
    })

    it("should return 401 if the token is missing or invalid", async () => {
      const res = await request(app)
        .get("/getUser")
        .set("Authorization", `Bearer ${validToken}`)

      expect(res.status).toBe(200)
      expect(res.body.Username).toBe("testuser")
    })
  })

  describe("POST /UserRegister", () => {
    it("should return 201 on successful registration", async () => {
      const res = await request(app)
        .post("/UserRegister")
        .send({
          Username: "newuser",
          Email: "newuser@example.com",
          Password: "password123"
        })

      expect(res.status).toBe(201)
      expect(res.body.message).toBe("Sikeres regisztráció")
    })

    it("should return 409 if user already exists", async () => {
      await dbhandler.User.create({
        Username: "existinguser",
        Password: "$2b$10$7.BkqxLjMZbODj01yNpFveJ5A1Ek8n5g34zT3ydJlmkUj8z8VktdAu",
        Email: "existinguser@example.com"
      })

      const res = await request(app)
        .post("/UserRegister")
        .send({
          Username: "existinguser",
          Email: "existinguser@example.com",
          Password: "password123"
        })

      expect(res.status).toBe(409);
      expect(res.body.message).toBe("Van már ilyen felhasználó");
    })
  })

  describe("GET /getUser", () => {
    let validToken
    let userId

    beforeAll(async () => {
      const hashedPassword = await bcrypt.hash('password123', 10)
      const user = await dbhandler.User.create({
        Username: "testuser",
        Password: hashedPassword,
        Email: "testuser@example.com",
      })

      userId = user.Id
      validToken = jwt.sign({ uid: user.Id }, process.env.SECRET_KEY, { expiresIn: '1h' })
    })

    it("should return the user data when requested", async () => {
      const res = await request(app)
        .get("/getUser")
        .set("Authorization", `Bearer ${validToken}`)

      expect(res.status).toBe(200)
      expect(res.body.Username).toBe("testuser")
      expect(res.body.Email).toBe("testuser@example.com")
    })
  })

  describe("PUT /EditUser", () => {
    let validToken
    let userId

    beforeAll(async () => {
      const hashedPassword = await bcrypt.hash('password123', 10)
      const user = await dbhandler.User.create({
        Username: "testuser",
        Password: hashedPassword,
        Email: "testuser@example.com",
      })
      userId = user.Id
      validToken = jwt.sign({ uid: user.Id }, process.env.SECRET_KEY, { expiresIn: '1h' })
    })

    it("should return 200 if user data is successfully updated", async () => {
      const res = await request(app)
        .put("/EditUser")
        .set("Authorization", `Bearer ${validToken}`)
        .send({ Username: "updateduser", Email: "updated@example.com", Password: "newpassword123", OldPassword: "password123" })

      expect(res.status).toBe(200)
      expect(res.body.message).toBe("Sikeres adatmódosítás!")
    });

    it("should return 400 if no data to update", async () => {
      const res = await request(app)
        .put("/EditUser")
        .set("Authorization", `Bearer ${validToken}`)
        .send({})
      expect(res.status).toBe(400)
      expect(res.body.message).toBe("Nincs módosítandó adat.")
    })
  })
  afterAll(async () => {
    await dbhandler.User.destroy({ where: {} });
  })
})
//Company tests

describe("Company API", () => {
  let validToken

  beforeAll(async () => {
    const hashedPassword = await bcrypt.hash('password123', 10)
    const user = await dbhandler.User.create({
      Username: "companyuser",
      Password: hashedPassword,
      Email: "companyuser@example.com",
    })

    validToken = jwt.sign({ uid: user.Id }, process.env.SECRET_KEY, { expiresIn: '1h' })
  })

  describe("POST /postCompany", () => {

    it("should create a new company", async () => {
      const res = await request(app)
        .post("/postCompany")
        .set("Authorization", `Bearer ${validToken}`)
        .send({
          Name: "Test Company",
          Description: "Test Description",
          Location: "Budapest"
        })

      expect(res.status).toBe(200)
      expect(res.body.message).toBe("Sikeres létrehozás")
    })

    it("should return 409 if company already exists", async () => {
      // már létező cég
      await dbhandler.Company.create({
        Name: "Existing Company",
        Description: "Desc",
        Location: "BP"
      })

      const res = await request(app)
        .post("/postCompany")
        .set("Authorization", `Bearer ${validToken}`)
        .send({
          Name: "Existing Company",
          Description: "Desc",
          Location: "BP"
        })

      expect(res.status).toBe(409)
      expect(res.body.message).toBe("Sikertelen létrehozás")
    })
  })

  describe("GET /getcompany", () => {

    it("should return all companies", async () => {
      await dbhandler.Company.create({
        Name: "Company1",
        Description: "Desc1",
        Location: "BP"
      })

      const res = await request(app)
        .get("/getcompany")

      expect(res.status).toBe(200)
      expect(Array.isArray(res.body)).toBe(true)
    })

    it("should return empty array if no companies", async () => {
      await dbhandler.Company.destroy({ where: {} })

      const res = await request(app)
        .get("/getcompany")

      expect(res.status).toBe(200)
      expect(res.body).toEqual([])
    })
  })

  afterAll(async () => {
    await dbhandler.Company.destroy({ where: {} })
  })
})
//Product Tests
describe("Product API", () => {
  let validToken
  let userId
  let companyId
  let productId

  beforeAll(async () => {
    // user a tokenhez
    const hashedPassword = await bcrypt.hash('password123', 10)
    const user = await dbhandler.User.create({
      Username: "productuser",
      Password: hashedPassword,
      Email: "productuser@example.com",
    })

    userId = user.Id
    validToken = jwt.sign({ uid: user.Id }, process.env.SECRET_KEY, { expiresIn: '1h' })

    const company = await dbhandler.Company.create({
      Name: "Test Company",
      Description: "Desc",
      Location: "BP"
    })

    companyId = company.Id
  })

  describe("POST /postproduct", () => {

    it("should create a new product", async () => {
      const res = await request(app)
        .post("/postproduct")
        .set("Authorization", `Bearer ${validToken}`)
        .send({
          Name: "Test Product",
          Description: "Test Desc",
          Price: 1000,
          Ammount: 10,
          CompanyId: companyId,
          IMGURL: "test.jpg"
        })

      expect(res.status).toBe(200)
      expect(res.body.message).toBe("Sikeres létrehozás")
    })

    it("should return 409 if product already exists", async () => {
      await dbhandler.Products.create({
        Name: "Existing Product",
        Description: "Desc",
        Price: 100,
        Ammount: 5,
        CompanyId: companyId,
        IMGURL: "img.jpg"
      })

      const res = await request(app)
        .post("/postproduct")
        .set("Authorization", `Bearer ${validToken}`)
        .send({
          Name: "Existing Product",
          Description: "Desc",
          Price: 100,
          Ammount: 5,
          CompanyId: companyId,
          IMGURL: "img.jpg"
        })

      expect(res.status).toBe(409)
      expect(res.body.message).toBe("Ez a terméknév már létezik!")
    })
  })

  describe("GET /getproduct", () => {

    it("should return all products", async () => {
      await dbhandler.Products.create({
        Name: "Get Product",
        Description: "Desc",
        Price: 200,
        Ammount: 3,
        CompanyId: companyId,
        IMGURL: "img.jpg"
      })

      const res = await request(app)
        .get("/getproduct")

      expect(res.status).toBe(200)
      expect(Array.isArray(res.body)).toBe(true)
    })
  })

  describe("PUT /updateproduct/:id", () => {

    beforeAll(async () => {
      const product = await dbhandler.Products.create({
        Name: "Update Product",
        Description: "Desc",
        Price: 100,
        Ammount: 5,
        CompanyId: companyId,
        IMGURL: "img.jpg"
      })

      productId = product.Id
    })

    it("should update a product", async () => {
      const res = await request(app)
        .put(`/updateproduct/${productId}`)
        .set("Authorization", `Bearer ${validToken}`)
        .send({
          Name: "Updated Product",
          Description: "Updated Desc",
          Price: 999,
          Ammount: 1,
          IMGURL: "updated.jpg"
        })

      expect(res.status).toBe(200)
      expect(res.body.message).toBe("Termék sikeresen frissítve")
    })
  })

  describe("DELETE /deleteproduct/:id", () => {

    let deleteId

    beforeAll(async () => {
      const product = await dbhandler.Products.create({
        Name: "Delete Product",
        Description: "Desc",
        Price: 100,
        Ammount: 5,
        CompanyId: companyId,
        IMGURL: "img.jpg"
      })

      deleteId = product.Id
    })

    it("should delete a product", async () => {
      const res = await request(app)
        .delete(`/deleteproduct/${deleteId}`)
        .set("Authorization", `Bearer ${validToken}`)

      expect(res.status).toBe(200)
      expect(res.body.message).toBe("Termék törölve")
    })
  })

  afterAll(async () => {
    await dbhandler.Products.destroy({ where: {} })
    await dbhandler.Company.destroy({ where: {} })
    await dbhandler.User.destroy({ where: {} })
  })
})
//Address tests
describe("Address API", () => {
  let validToken
  let userId

  beforeAll(async () => {
    const hashedPassword = await bcrypt.hash('password123', 10)

    const user = await dbhandler.User.create({
      Username: "addressuser",
      Password: hashedPassword,
      Email: "addressuser@example.com",
    })

    userId = user.Id
    validToken = jwt.sign({ uid: user.Id }, process.env.SECRET_KEY, { expiresIn: '1h' })
  })

  describe("POST /AddressRegister", () => {

    it("should create a new address", async () => {
      const res = await request(app)
        .post("/AddressRegister")
        .set("Authorization", `Bearer ${validToken}`)
        .send({
          City: "Budapest",
          Zip: 1111,
          Address1: "Teszt utca 1"
        })

      expect(res.status).toBe(201)
      expect(res.body.message).toBe("Sikeres Lakhely regisztráció")
    })
  })

  describe("GET /AddressGets", () => {

    it("should return the user's address", async () => {
      await dbhandler.Address.create({
        City: "Budapest",
        Zip: 2222,
        Address1: "Másik utca 2",
        UserId: userId
      })

      const res = await request(app)
        .get("/AddressGets")
        .set("Authorization", `Bearer ${validToken}`)

      expect(res.status).toBe(200)
      expect(res.body.City).toBe("Budapest")
    })

    it("should return 404 if no address exists", async () => {
      await dbhandler.Address.destroy({ where: { UserId: userId } })

      const res = await request(app)
        .get("/AddressGets")
        .set("Authorization", `Bearer ${validToken}`)

      expect(res.status).toBe(404)
      expect(res.body.message).toBe("Nincs ilyen Lakhely")
    })
  })

  describe("PUT /EditAddress", () => {

    beforeAll(async () => {
      await dbhandler.Address.create({
        City: "Old City",
        Zip: 1234,
        Address1: "Old address",
        UserId: userId
      })
    })

    it("should update the address", async () => {
      const res = await request(app)
        .put("/EditAddress")
        .set("Authorization", `Bearer ${validToken}`)
        .send({
          City: "New City",
          Zip: 9999,
          Address1: "New address"
        })

      expect(res.status).toBe(200)
      expect(res.body.message).toBe("Sikeres módosítás")
    })

    it("should return 400 if data is missing", async () => {
      const res = await request(app)
        .put("/EditAddress")
        .set("Authorization", `Bearer ${validToken}`)
        .send({
          City: "Only City"
        })

      expect(res.status).toBe(400)
      expect(res.body.message).toBe("Hiányzó adatok")
    })

    it("should return 404 if address does not exist", async () => {
      await dbhandler.Address.destroy({ where: { UserId: userId } })

      const res = await request(app)
        .put("/EditAddress")
        .set("Authorization", `Bearer ${validToken}`)
        .send({
          City: "Test",
          Zip: 1111,
          Address1: "Test"
        })

      expect(res.status).toBe(404)
      expect(res.body.message).toBe("Nincs mentett cím ehhez a felhasználóhoz")
    })
  })

  afterAll(async () => {
    await dbhandler.Address.destroy({ where: {} })
    await dbhandler.User.destroy({ where: {} })
  })
})
//Billing Address Test
describe("Billing Address API", () => {
  let validToken
  let userId

  beforeAll(async () => {
    const hashedPassword = await bcrypt.hash('password123', 10)

    const user = await dbhandler.User.create({
      Username: "billinguser",
      Password: hashedPassword,
      Email: "billinguser@example.com",
    })

    userId = user.Id
    validToken = jwt.sign({ uid: user.Id }, process.env.SECRET_KEY, { expiresIn: '1h' })
  })

  describe("POST /BillingAddressRegister", () => {

    it("should create a new billing address", async () => {
      const res = await request(app)
        .post("/BillingAddressRegister")
        .set("Authorization", `Bearer ${validToken}`)
        .send({
          City: "Budapest",
          Zip: 1111,
          Address1: "Számla utca 1"
        })

      expect(res.status).toBe(201)
      expect(res.body.message).toBe("Sikeres számlázási cím regisztráció")
    })
  })

  describe("GET /BillingAddressGets", () => {

    it("should return billing address", async () => {
      await dbhandler.BillingAddress.destroy({ where: { UserId: userId } })

      await dbhandler.BillingAddress.create({
        City: "Debrecen",
        Zip: 2222,
        Address1: "Számla utca 2",
        UserId: userId
      })

      const res = await request(app)
        .get("/BillingAddressGets")
        .set("Authorization", `Bearer ${validToken}`)

      expect(res.status).toBe(200)
      expect(res.body.City).toBe("Debrecen")
    })
    it("should return 404 if no billing address", async () => {
      await dbhandler.BillingAddress.destroy({ where: { UserId: userId } })

      const res = await request(app)
        .get("/BillingAddressGets")
        .set("Authorization", `Bearer ${validToken}`)

      expect(res.status).toBe(404)
      expect(res.body.message).toBe("Nincs ilyen számlázási cím")
    })
  })

  describe("PUT /EditBillingAddress", () => {

    beforeAll(async () => {
      await dbhandler.BillingAddress.create({
        City: "Old City",
        Zip: 1234,
        Address1: "Old billing address",
        UserId: userId
      })
    })

    it("should update billing address", async () => {
      const res = await request(app)
        .put("/EditBillingAddress")
        .set("Authorization", `Bearer ${validToken}`)
        .send({
          City: "New City",
          Zip: 9999,
          Address1: "New billing address"
        })

      expect(res.status).toBe(200)
      expect(res.body.message).toBe("Sikeres módosítás")
    })

    it("should return 400 if missing data", async () => {
      const res = await request(app)
        .put("/EditBillingAddress")
        .set("Authorization", `Bearer ${validToken}`)
        .send({
          City: "Only City"
        })

      expect(res.status).toBe(400)
      expect(res.body.message).toBe("Hiányzó adatok")
    })

    it("should return 404 if billing address does not exist", async () => {
      await dbhandler.BillingAddress.destroy({ where: { UserId: userId } })

      const res = await request(app)
        .put("/EditBillingAddress")
        .set("Authorization", `Bearer ${validToken}`)
        .send({
          City: "Test",
          Zip: 1111,
          Address1: "Test"
        })

      expect(res.status).toBe(404)
      expect(res.body.message).toBe("Nincs mentett számlázási cím")
    })
  })

  afterAll(async () => {
    await dbhandler.BillingAddress.destroy({ where: {} })
    await dbhandler.User.destroy({ where: {} })
  })
})
//Order tests
describe("Order API", () => {
  let validToken;
  let userId;
  let addressId;
  let productId;

  beforeAll(async () => {
    // 1️⃣ Felhasználó létrehozása
    const hashedPassword = await bcrypt.hash('password123', 10);
    const user = await dbhandler.User.create({
      Username: "orderuser",
      Password: hashedPassword,
      Email: "orderuser@example.com",
    });
    userId = user.Id;
    validToken = jwt.sign({ uid: user.Id }, process.env.SECRET_KEY, { expiresIn: '1h' });

    // 2️⃣ Szállítási cím létrehozása
    const address = await dbhandler.Address.create({
      City: "Budapest",
      Zip: 1111,
      Address1: "Teszt utca 5",
      UserId: userId
    });
    addressId = address.Id;

    // 3️⃣ Termék létrehozása
    const company = await dbhandler.Company.create({
      Name: "Teszt Cég",
      Description: "Teszt leírás",
      Location: "Budapest"
    });
    const product = await dbhandler.Products.create({
      Name: "Teszt termék",
      Description: "Leírás",
      Price: 1000,
      Ammount: 10,
      CompanyId: company.Id,
      IMGURL: "http://img.url/test.png"
    });
    productId = product.Id;
  });

  describe("POST /createOrder", () => {

    it("should create a new order", async () => {
      const res = await request(app)
        .post("/createOrder")
        .set("Authorization", `Bearer ${validToken}`)
        .send({
          AddressId: addressId,
          cart: [
            { Id: productId, Name: "Teszt termék", Price: 1000, quantity: 2 }
          ]
        });

      expect(res.status).toBe(201);
      expect(res.body.message).toBe("Rendelés sikeres!");
      expect(res.body).toHaveProperty("orderId");

      // Ellenőrizzük, hogy csökkent a készlet
      const product = await dbhandler.Products.findByPk(productId);
      expect(product.Ammount).toBe(8); // 10 - 2
    });

    it("should return 400 if cart is empty", async () => {
      const res = await request(app)
        .post("/createOrder")
        .set("Authorization", `Bearer ${validToken}`)
        .send({
          AddressId: addressId,
          cart: []
        });
      expect(res.status).toBe(400);
      expect(res.body.message).toBe("Üres a kosár");
    });

    it("should return 400 if AddressId is missing", async () => {
      const res = await request(app)
        .post("/createOrder")
        .set("Authorization", `Bearer ${validToken}`)
        .send({
          cart: [{ Id: productId, Name: "Teszt termék", Price: 1000, quantity: 1 }]
        });
      expect(res.status).toBe(400);
      expect(res.body.message).toBe("Hiányzó cím azonosító");
    });
  });

  describe("GET /getMyOrders", () => {

    it("should return orders for the logged-in user", async () => {
      const res = await request(app)
        .get("/getMyOrders")
        .set("Authorization", `Bearer ${validToken}`);

      expect(res.status).toBe(200);
      expect(Array.isArray(res.body)).toBe(true);
      if (res.body.length > 0) {
        expect(res.body[0]).toHaveProperty("OrderItems");
        expect(res.body[0]).toHaveProperty("Address");
      }
    });
  });

  afterAll(async () => {
    // Tisztítás a tesztek után
    await dbhandler.OrderItem.destroy({ where: {} });
    await dbhandler.Order.destroy({ where: {} });
    await dbhandler.Products.destroy({ where: {} });
    await dbhandler.Company.destroy({ where: {} });
    await dbhandler.Address.destroy({ where: {} });
    await dbhandler.User.destroy({ where: {} });
  });
});