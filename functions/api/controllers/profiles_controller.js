const profilesModel = require("../models/profiles_model");
const express = require("express");
const router = express.Router();

// profiles/ (get all profiles data)
router.get("/", async (req, res, next) => {
    try {
        const result = await profilesModel.get();
        return res.json(result);
    } catch (e) {
        return next(e);
    }
});

// profiles/{id} (get specific profile data)
router.get("/:id", async (req, res, next) => {
    try {
        const result = await profilesModel.getById(req.params.id);
        if (!result) return res.sendStatus(404);
        return res.json(result);
    } catch (e) {
        return next(e);
    }
});

router.post("/", async (req, res, next) => {
    try {
        const result = await profilesModel.setId(req.body);
        if (!result) return res.sendStatus(409);
        return res.status(201).json(result);
    } catch (e) {
        return next(e);
    }
});

router.delete("/:id", async (req, res, next) => {
    try {
        const result = await profilesModel.delete(req.params.id);
        if (!result) return res.sendStatus(404);
        return res.sendStatus(200);
    } catch (e) {
        return next(e);
    }
});

// profiles/{id} (update certain data from profile)
router.patch("/:id", async (req, res, next) => {
    try {
        const id = req.params.id;
        const data = req.body;

        const doc = await profilesModel.getById(id);
        if (!doc) return res.sendStatus(404);

        // Merge existing fields with the ones to be updated
        Object.keys(data).forEach((key) => (doc[key] = data[key]));

        const updateResult = await profilesModel.update(id, doc);
        if (!updateResult) return res.sendStatus(404);

        return res.json(doc);
    } catch (e) {
        return next(e);
    }
});


// profile{id} (update all data from profile/replace the whole data from profile)
router.put("/:id", async (req, res, next) => {
    try {
        const updateResult = await profilesModel.update(req.params.id, req.body);
        if (!updateResult) return res.sendStatus(404);

        const result = await profilesModel.getById(req.params.id);
        return res.json(result);
    } catch (e) {
        return next(e);
    }
});

module.exports = router;
